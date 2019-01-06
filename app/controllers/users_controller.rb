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
			redirect_to users_password_edit_path(@current_user.id)
			flash[:danger] = "メールアドレスとパスワードが一致しません。"
		end
	end

	def logout
		session[:user_id] = nil
		redirect_to root_path
		flash[:info] = "ログアウトしました。"
	end

	def index
		@users = User.all
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
			flash[:danger] = "パスワードが一致しません。"
		end
	end

	def show
		@user = User.find_by(id: params[:id])
	end

	def update
		@user = User.find_by(id: params[:id])
		@user.update(user_params)
		redirect_to user_path(@current_user.id)
	end

	def destroy
		@user = User.find_by(id: params[:id])
		@user.destroy
		redirect_to new_user_path
		flash[:danger] = "ユーザーを削除しました。"
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_id, :facebook, :twitter, :instagram, :youtube, :user_text)
	end

end
