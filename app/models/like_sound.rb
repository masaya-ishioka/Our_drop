class LikeSound < ApplicationRecord
	validates :user_id, presence: true
	validates :sound_id, presence: true

	belongs_to :sound
	belongs_to :user
end
