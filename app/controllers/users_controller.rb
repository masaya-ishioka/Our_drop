class UsersController < ApplicationController
	before_action :not_current_user, {only: [:like_index, :edit, :update, :password_edit, :password_update, :destroy]}
	before_action :user_active, {only: [:active, :active_update]}
	before_action :not_user_active, {only: [:like_index, :edit, :update, :password_edit, :password_update, :destroy, :show]}
	before_action :ensure_correct_user, {only: [:like_index, :edit, :update, :password_edit, :password_update, :destroy]}

	def top
	end

	def new
		@user = User.new
	end

	def active
		@user = User.find_by(id: params[:id])
		session[:user_id] = @user.id
	end

	def active_update
		@user = User.find_by(id: params[:id])
		@user.update(user_params)
		redirect_to root_path
		flash[:info] = "アカウント有効化しました。"
	end

	def create
		@user = User.new(user_params)
		if @user.save
			UserMailer.active(@user).deliver_now
			session[:user_id] = @user.id
			redirect_to root_path
			flash[:info] = "送信されたメールからユーザー有効化してください。"
		else
			flash.now[:danger] = "ERROR_※は必須項目です。"
			render :new
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
			flash.now[:danger] = "ERROR_メールアドレスとパスワードが一致しません。"
			render :login_form
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

	def password_forget
	end

	def email_where
		if @user = User.find_by(email: params[:email_where][:email])
			@user.password_forget = Time.now
			@user.save
			PasswordForgetMailer.password_forget(@user).deliver_now
			redirect_to root_path
			flash[:info] = "送信されたメールから１時間以内にパスワードを変更してください。"
		else
			flash.now[:danger] = "ERROR_メールアドレスが間違っています。"
			render users_password_forget_path
		end
	end

	def password_forget_edit
		@user = User.find_by(id: params[:id])
		if (Time.zone.now - @user.password_forget) < 1.hours
		else
			redirect_to root_path
			flash[:danger] = "ERROR_有効時間が過ぎています。または変更済みです。"
		end
	end

	def password_forget_update
		@user = User.find_by(id: params[:id])
		if (Time.zone.now - @user.password_forget) < 1.hours
			if @user.update(user_params)
				binding.pry
				@user.password_forget = @user.password_forget - 2.hour
				binding.pry
				@user.save
				redirect_to root_path
				flash[:info] = "パスワードを変更しました。"
			else
				flash.now[:danger] = "ERROR_パスワードが一致しません。"
				render :password_forget_edit
			end
		else
			redirect_to root_path
			flash[:danger] = "ERROR_有効時間が過ぎています。または変更済みです。"
		end
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
			flash.now[:danger] = "ERROR_パスワードが一致しません。"
			render :password_edit
		end
	end

	def show
		@user = User.find_by(id: params[:id])
		uri_reg = URI.regexp(%w[http https])
		if @user.user_text
			@user.user_text.gsub!(uri_reg) {%Q{<a href="#{$&}">#{$&}</a>}}
		end
	end

	def update
		@user = User.find_by(id: params[:id])
		if @user.update(user_params)
			redirect_to user_path(@current_user.id)
			flash[:success] = "プロフィールを変更しました。"
		else
			flash.now[:danger] = "ERROR_内容を確認してください。"
			render :edit
		end
	end

	def destroy
		@user = User.find_by(id: params[:id])
		@user.destroy
		redirect_to new_user_path
		flash[:danger] = "ユーザーを削除しました。"
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :facebook, :twitter, :instagram, :youtube, :user_text, :active)
	end

	def user_active
    	if @current_user
	    	if @current_user.active == true
	    		redirect_to root_path
	    		flash[:danger] = "すでに有効化されています。"
	    	end
	    end
    end

    def ensure_correct_user
    	if @current_user.admin == true
        elsif @current_user.id != params[:id].to_i
            redirect_to root_path
            flash[:danger] = "ログインしてください。または、権限がありません。"
        end
    end

end
