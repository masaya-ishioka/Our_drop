class AddUserText < ActiveRecord::Migration[5.2]
  def change
   add_column :users, :user_text, :text
  end
end
