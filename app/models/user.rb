class User < ApplicationRecord
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
    has_secure_password
    attachment :image

    has_many :sounds, dependent: :destroy
    has_many :like_sounds, dependent: :destroy
    has_many :like_user, dependent: :destroy

end
