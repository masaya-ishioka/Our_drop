class LikeUser < ApplicationRecord
	validates :user_id, presence: true
	validates :my_id, presence: true

	belongs_to :user, dependent: :destroy
end
