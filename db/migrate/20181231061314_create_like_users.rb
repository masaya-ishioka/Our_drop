class CreateLikeUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :like_users, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.integer :my_id
      t.integer :user_id

      t.timestamps
    end
  end
end
