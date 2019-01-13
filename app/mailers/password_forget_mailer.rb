class PasswordForgetMailer < ApplicationMailer
def password_forget(user)
    @user = user
    mail to: user.email, subject:"Our drop password_forget"
  end
end
