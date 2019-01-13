class LikeSoundsController < ApplicationController
	before_action :not_current_user
	before_action :not_user_active
	before_action :set_variables

	def create
		@like = @current_user.like_sounds.new(sound_id: @sound.id)
		@like.save
	end

	def destroy
		@like = @current_user.like_sounds.find_by(sound_id: @sound.id)
		@like.destroy
	end

	private

	def set_variables
	  @sound = Sound.find(params[:sound_id])
	  @id_name = "#like-link-#{@sound.id}"
	end
end
