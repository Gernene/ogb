class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end
  
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
  
  def request_send(request)
    @request = request
    mail to: @request.post.user.email, subject: "Pending Request"
  end
  
  def request_accept(request)
    @request = request
    mail to: @request.user.email, subject: "Request Accepted"
  end
  
  def request_decline(request)
    @request = request
    mail to: @request.user.email, subject: "Request Declined"
  end
  
  def contact_email(name, email, title, message)
    @name = name
    @email = email
    @title = title
    @message = message
    mail subject: @title
  end
end