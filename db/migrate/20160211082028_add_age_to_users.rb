class AddAgeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :age, :integer
    add_column :users, :country, :string
    add_column :users, :introduction, :string
    add_column :users, :url, :string
  end
end
