class ApplicationController < ActionController::Base
	before_action :set_current_user

	private
	def set_current_user
		@current_user = User.find_by(id: session[:user_id])
    end

    def not_user_active
      	if @current_user.active == false
    		redirect_to root_path
    		flash[:danger] = "送られたメールからアカウントを有効化してください。"
    	end
    end
end