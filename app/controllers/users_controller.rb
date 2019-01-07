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
			flash[:danger] = "ERROR_※は必須項目です。"
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
			flash[:danger] = "ERROR_メールアドレスとパスワードが一致しません。"
		end
	end

	def logout
		session[:user_id] = nil
		redirect_to root_path
		flash[:info] = "ログアウトしました。"
	end

	def index
		@users = User.search(params)
	end

	def like_index
		users = LikeUser.where(my_id: @current_user.id)
		@users = User.where(id: users.pluck(:user_id))
		sounds = LikeSound.where(user_id: @current_user.id)
		@sounds = Sound.where(id: sounds.pluck(:sound_id))
	end

	def edit
		@user = User.find_by(id: params[:id])
	end

	def password_edit
		@user = User.find_by(id: params[:id])
	end

	def password_update
		@user = User.find_by(id: params[:id])
		if @user.update(user_params)
			session[:user_id] = nil
			redirect_to root_path
			flash[:info] = "パスワードを変更しました。"
		else
			render :password_edit
			flash[:danger] = "ERROR_パスワードが一致しません。"
		end
	end

	def show
		@user = User.find_by(id: params[:id])
	end

	def update
		@user = User.find_by(id: params[:id])
		@user.update(user_params)
		redirect_to user_path(@current_user.id)
		flash[:success] = "プロフィールを変更しました。"
	end

	def destroy
		@user = User.find_by(id: params[:id])
		@user.destroy
		redirect_to new_user_path
		flash[:danger] = "ユーザーを削除しました。"
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :facebook, :twitter, :instagram, :youtube, :user_text)
	end

end
