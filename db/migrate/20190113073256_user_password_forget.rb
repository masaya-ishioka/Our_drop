class UserPasswordForget < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :password_forget, :datetime
  end
end
