class SoundsController < ApplicationController
	before_action :success

	def new
		@sound = Sound.new
	end

	def create
		@sound = Sound.new(sound_params)
		url = @sound.url.sub(/www.dropbox/,'dl.dropboxusercontent')
		@sound.url = url
		@sound.save
		redirect_to root_path
	end

	def index
		@sounds = Sound.all
	end

	def edit
	end

	def show
		@sound = Sound.find_by(id: params[:id])
		response.headers['X-Frame-Options'] = 'ALLOWALL #{@sound.url}'
	end

	def update
	end

	def destroy
		@sound = Sound.find_by(id: params[:id])
		@sound.destroy
		redirect_to sounds_path
	end

	private
	def sound_params
		params.require(:sound).permit(:url, :title, :user_id)
	end

	def success
		response.headers['X-Frame-Options'] = 'ALLOWALL'
	end
end
