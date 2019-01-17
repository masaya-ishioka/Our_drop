class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.string :name
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
