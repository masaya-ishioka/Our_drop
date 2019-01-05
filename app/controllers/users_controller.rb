class UsersController < ApplicationController
	def top
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to root_path
		else
			render :new
			flash[:danger] = "※は必須項目です。"
		end
	end

	def login_form
	end

	def login
		@user = User.find_by(email: params[:login][:email])
		if @user && @user.authenticate(params[:login][:password])
			session[:user_id] = @user.id
			redirect_to sounds_path
			flash[:success] = "ログインしました。"
		else
			render :login_form
			flash[:danger] = "メールアドレスとパスワードが一致しません。"
		end
	end

	def logout
		session[:user_id] = nil
		redirect_to users_login_path
		flash[:info] = "ログアウトしました。"
	end

	def index
		@users = User.all
	end

	def edit
		@user = User.find_by(id: params[:id])
	end

	def show
		@user = User.find_by(id: params[:id])
	end

	def update
		@user = User.find_by(id: params[:id])
		@user.update(user_params)
		redirect_to :show
	end

	def destroy
		@user = User.find_by(id: params[:id])
		@user.destroy
		redirect_to new_user_path
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_id)
	end

end
