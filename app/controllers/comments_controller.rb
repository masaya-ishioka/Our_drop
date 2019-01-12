class CommentsController < ApplicationController
	before_action :not_user_active
	before_action :set_variables
	def create
		@comment = Comment.new(user_id: @current_user.id, sound_id: params[:sound_id], comment: params[:comment][:comment])
		if @comment.save
			redirect_to sound_path(params[:sound_id])
			flash[:success] = "コメントを投稿しました。"
		else
			flash.now[:danger] = "投稿に失敗しました。"
			render sounds_path(params[:sound_id])
		end
	end

	def destroy
		@comment = Comment.find_by(id: params[:id])
		if @current_user.admin == true
			@comment.destroy
			redirect_to sound_path(params[:sound_id])
			flash[:danger] = "コメントを削除しました。"
		elsif @current_user.id != @comment.user_id
			redirect_to root_path
        	flash[:danger] = "権限がありません。"
        else
			@comment.destroy
			redirect_to sound_path(params[:sound_id])
			flash[:danger] = "コメントを削除しました。"
		end
	end

	private

	def set_variables
	  @sound = Sound.find(params[:sound_id])
	  @id_name = "#like-link-#{@sound.id}"
	end
end
