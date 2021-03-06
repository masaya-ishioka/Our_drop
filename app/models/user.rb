class User < ApplicationRecord
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
    validates :user_text, length: {maximum: 200}
    has_secure_password
    attachment :image

    has_many :sounds, dependent: :destroy
    has_many :like_sounds, dependent: :destroy
    has_many :like_user, dependent: :destroy
    has_many :comments, dependent: :destroy
    def self.search(params)
        results = all.order(created_at: :desc)
        results = results.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
    	results
    end
end
