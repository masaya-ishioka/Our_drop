class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.save
	end

	def index
		@users = User.all
	end

	def edit
	end

	def show
		@user = User.find_by(id: params[:id])
	end

	def update
	end

	def destroy
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password)
	end

end
