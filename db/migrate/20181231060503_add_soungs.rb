class AddSoungs < ActiveRecord::Migration[5.2]
  def change
  	add_column :sounds, :tag1, :string
  	add_column :sounds, :tag2, :string
  	add_column :sounds, :tag3, :string
  	add_column :sounds, :sound_text, :text
  end
end
