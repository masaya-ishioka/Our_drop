class CreateSounds < ActiveRecord::Migration[5.2]
  def change
    create_table :sounds, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.string :url
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end
