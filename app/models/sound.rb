class Sound < ApplicationRecord
	validates :url, presence: true
	validates :title, presence: true
	validates :user_id, presence: true
	validates :tag1, presence: true
	validates :sound_text, length: {maximum: 200}

	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :like_sounds, dependent: :destroy

	def self.search(params)
        results = all.order(created_at: :desc)
        results = results.where('title LIKE ?', "%#{params[:search]}%") if params[:search].present?
	    results = results.where('tag1 LIKE ?', params[:search1]) if params[:search1].present?
 		results = results.where('tag2 LIKE ?', params[:search2]) if params[:search2].present?
	    results = results.where('tag3 LIKE ?', params[:search3]) if params[:search3].present?
    	results
    end
end
