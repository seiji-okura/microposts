class User < ActiveRecord::Base
  #VALID_EMAIL_REGEX  = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_EMAIL_REGEXP  = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {maximum: 50 }
  validates :email, presence: true, length: {maximum: 255 },
                    format: {with: VALID_EMAIL_REGEXP },
                    uniqueness: { case_sensitive: false }
  validates :age, numericality:{only_integer: true, greater_than_or_equal_to: 0}, presence: true, on: :update


  has_secure_password
  
end
