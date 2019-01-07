class Comment < ApplicationRecord
	validates :user_id, presence: true
	validates :sound_id, presence: true
	validates :comment, length: {maximum: 140}

	belongs_to :sound
	belongs_to :user
end
