class SoundsController < ApplicationController

	def new
		@sound = Sound.new
	end

	def create
		@sound = Sound.new(sound_params)
		url = @sound.url.sub(/www.dropbox/,'dl.dropboxusercontent')
		@sound.url = url
		@sound.user_id = @current_user.id
		@sound.save
		redirect_to sounds_path
		flash[:success] = "投稿しました。"
	end

	def index
		@sounds = Sound.all
	end

	def edit
		@sound = Sound.find_by(id: params[:id])
	end

	def show
		@sound = Sound.find_by(id: params[:id])
		response.headers['X-Frame-Options'] = 'ALLOWALL #{@sound.url}'
		@comment = Comment.new
		@comments = Comment.where(sound_id: @sound.id)
	end

	def update
		@sound = Sound.find_by(id: params[:id])
		if @sound.update(sound_params)
			url = @sound.url.sub(/www.dropbox/,'dl.dropboxusercontent')
			@sound.url = url
			@sound.save
			redirect_to sound_path(params[:id])
			flash[:success] = "編集完了しました。"
		else
			render :edit
			flash[:danger] = "編集に失敗しました。内容を確認してください。"
		end
	end

	def destroy
		@sound = Sound.find_by(id: params[:id])
		@sound.destroy
		redirect_to sounds_path
	end

	private
	def sound_params
		params.require(:sound).permit(:url, :title, :user_id, :tag1, :tag2, :tag3, :sound_text)
	end
end
