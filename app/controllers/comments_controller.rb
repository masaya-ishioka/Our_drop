class CommentsController < ApplicationController
	before_action :not_user_active
	def create
		@comment = Comment.new(user_id: @current_user.id, sound_id: params[:sound_id], comment: params[:comment][:comment])
		if @comment.save
			redirect_to sound_path(params[:sound_id])
			flash[:success] = "コメントを投稿しました。"
		else
			render sounds_path(params[:sound_id])
			flash[:danger] = "投稿に失敗しました。"
		end
	end

	def destroy
		@comment = Comment.find_by(id: params[:id])
		@comment.destroy
		redirect_to sound_path(params[:sound_id])
		flash[:danger] = "コメントを削除しました。"
	end
end
