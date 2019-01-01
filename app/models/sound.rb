class Sound < ApplicationRecord
	validates :url, presence: true
	validates :title, presence: true
	validates :user_id, presence: true
	validates :tag_1, presence: true
	validates :sound_text, length: {maximum: 140}

	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :like_sounds, dependent: :destroy
end
