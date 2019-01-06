class LikeSoundsController < ApplicationController
	def create
		@like = LikeSound.new(user_id: @current_user.id,sound_id: params[:sound_id])
	end

	def destroy
	end
end
