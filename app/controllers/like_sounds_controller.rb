class LikeSoundsController < ApplicationController
	def create
		@like = LikeSound.new(user_id: @current_user.id, sound_id: params[:sound_id])
		@like.save
		redirect_to sound_path(params[:sound_id])
		flash[:success] = "お気に入りに追加しました。"
	end

	def destroy
		@like = LikeSound.find_by(user_id: @current_user.id, sound_id: params[:sound_id])
		@like.destroy
		redirect_to sound_path(params[:sound_id])
		flash[:danger] = "お気に入りを解除しました。"
	end
end
