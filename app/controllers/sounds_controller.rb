class SoundsController < ApplicationController

	def new
		@sound = Sound.new
	end

	def create
		@sound = Sound.new(sound_params)
		url = @sound.url.sub(/www.dropbox/,'dl.dropboxusercontent')
		@sound.url = url
		@sound.user_id = @current_user.id
		if @sound.save
			redirect_to sounds_path
			flash[:success] = "投稿しました。"
		else
			render new_sound_path
			flash[:danger] = "ERROR_投稿内容を確認してください。"
		end
	end

	def index
		@sounds = Sound.search(params)
	end

	def day_rank
		@sounds = Sound.search(params)
		@like_day = LikeSound.where(created_at: 1.day.ago..Time.now)
		@sounds_day = @like_day.where(sound_id: @sounds.pluck(:id))
		@sound_ranking = @sounds.find(@sounds_day.group(:sound_id).order('count(sound_id) desc').pluck(:sound_id))
	end

	def week_rank
		@sounds = Sound.search(params)
		@like_week = LikeSound.where(created_at: 1.week.ago..Time.now)
		@sounds_week = @like_week.where(sound_id: @sounds.pluck(:id))
		@sound_ranking = @sounds.find(@sounds_week.group(:sound_id).order('count(sound_id) desc').pluck(:sound_id))
	end

	def month_rank
		@sounds = Sound.search(params)
		@like_month = LikeSound.where(created_at: 1.month.ago..Time.now)
		@sounds_month = @like_month.where(sound_id: @sounds.pluck(:id))
		@sound_ranking = @sounds.find(@sounds_month.group(:sound_id).order('count(sound_id) desc').pluck(:sound_id))
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
			flash[:danger] = "ERROR_内容を確認してください。"
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
