class LikeUsersController < ApplicationController
	def create
		@like = LikeUser.new(my_id: @current_user.id, user_id: params[:user_id])
		@like.save
		redirect_to user_path(params[:user_id])
		flash[:success] = "お気に入りに追加しました。"
	end

	def destroy
		@like = LikeUser.find_by(my_id: @current_user.id, user_id: params[:user_id])
		@like.destroy
		redirect_to user_path(params[:user_id])
		flash[:danger] = "お気に入りを解除しました。"
	end
end
