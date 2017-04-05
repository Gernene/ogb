class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end
  
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
  
  def request_accept(request)
    @request = request
  end
  
  def request_decline(request)
    @request = request
  end
  
  def post_cancelled(request)
    @request = request
  end
end