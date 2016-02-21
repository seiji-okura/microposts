class User < ActiveRecord::Base
  VALID_EMAIL_REGEXP  = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {maximum: 50 }
  validates :email, presence: true, length: {maximum: 255 },
                    format: {with: VALID_EMAIL_REGEXP },
                    uniqueness: { case_sensitive: false }
  validates :age, numericality:{only_integer: true, greater_than_or_equal_to: 0}, presence: true, on: :update


  has_secure_password
  
  has_many :microposts
  
  # users that, who dou you follow
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  
  # users that, follow you
  has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  
  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    #binding.pry
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # このユーザーをフォローしている？
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  def feed_items
    ret = Micropost.where(user_id: following_user_ids + [self.id])
    return ret
  end
  
end
