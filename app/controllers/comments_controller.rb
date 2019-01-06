class CommentsController < ApplicationController
	def edit
	end

	def update
		@comment = Comment.find_by(id: params[:id])
		if @comment.update(comment: params[:comment])
			redirect_to sounds_path(params[:sound_id])
			flash[:success] = "コメントを更新しました。"
		else
			render sounds_path(params[:sound_id])
			flash[:danger] = "更新に失敗しました。"
		end
	end

	def create
		@comment = Comment.new(user_id: @current_user.id, sound_id: params[:sound_id], comment: params[:comment])
		if @comment.save
			redirect_to sounds_path(params[:sound_id])
			flash[:success] = "コメントを投稿しました。"
		else
			render sounds_path(params[:sound_id])
			flash[:danger] = "投稿に失敗しました。"
		end
	end

	def destroy
		@comment = Comment.find_by(id: params[:id])
		@comment.destroy
		redirect_to sounds_path(params[:sound_id])
		flash[:danger] = "コメントを削除しました。"
	end
end
