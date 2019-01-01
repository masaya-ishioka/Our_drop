class LikeSound < ApplicationRecord
	validates :user_id, presence: true
	validates :sound_id, presence: true

	belongs_to :sound, dependent: :destroy
	belongs_to :user, dependent: :destroy
end
