class SoundsController < ApplicationController
	before_action :not_current_user, {only: [:edit, :update, :destroy, :new, :create]}
	before_action :not_user_active, {only: [:edit, :show, :update, :destroy, :new, :create]}

	def new
		@sound = Sound.new
	end

	def create
		@sound = Sound.new(sound_params)
		if @sound.url.include?("www.dropbox")
			url = @sound.url.sub(/www.dropbox/,'dl.dropboxusercontent')
			@sound.url = url
			@sound.user_id = @current_user.id
			if @sound.save
				redirect_to sounds_path
				flash[:success] = "投稿しました。"
			else
				flash.now[:danger] = "ERROR_※は必須項目です。"
				render new_sound_path
			end
		else
			flash.now[:danger] = "ERROR_共有用URLを入力してください。"
			render new_sound_path
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
		if @current_user.admin ==true
		elsif @current_user.id != @sound.user_id
           redirect_to root_path
           flash[:danger] = "権限がありません。"
        end
	end

	def show
		@sound = Sound.find_by(id: params[:id])
		uri_reg = URI.regexp(%w[http https])
		@sound.sound_text.gsub!(uri_reg) {%Q{<a href="#{$&}">#{$&}</a>}}
		response.headers['X-Frame-Options'] = 'ALLOWALL #{@sound.url}'
		@comment = Comment.new
		@comments = Comment.where(sound_id: @sound.id)
	end

	def update
		@sound = Sound.find_by(id: params[:id])
		if @current_user.id != @sound.user_id
           redirect_to root_path
           flash[:danger] = "権限がありません。"
		else
			if params[:sound][:url].include?("www.dropbox")
				if @sound.update(sound_params)
					url = @sound.url.sub(/www.dropbox/,'dl.dropboxusercontent')
					@sound.url = url
					@sound.save
					redirect_to user_path(@current_user.id)
					flash[:success] = "編集完了しました。"
				else
					flash.now[:danger] = "ERROR_内容を確認してください。"
					render :edit
				end
			elsif params[:sound][:url].include?("dl.dropboxusercontent")
				if @sound.update(sound_params)
					url = @sound.url.sub(/www.dropbox/,'dl.dropboxusercontent')
					@sound.url = url
					@sound.save
					redirect_to user_path(@current_user.id)
					flash[:success] = "編集完了しました。"
				else
					flash.now[:danger] = "ERROR_内容を確認してください。"
					render :edit
				end
			else
				flash.now[:danger] = "ERROR_共有用URLを入力してください。"
				render :edit
			end
		end
	end

	def destroy
		@sound = Sound.find_by(id: params[:id])
		if @current_user.admin == true
			@sound.destroy
			redirect_to users_path
			flash[:danger] = "投稿を削除しました。"
		elsif @current_user.id != @sound.user_id
           redirect_to root_path
           flash[:danger] = "権限がありません。"
        else
			@sound.destroy
			redirect_to user_path(@current_user.id)
			flash[:danger] = "投稿を削除しました。"
		end
	end

	private
	def sound_params
		params.require(:sound).permit(:url, :title, :user_id, :tag1, :tag2, :tag3, :sound_text)
	end
end
