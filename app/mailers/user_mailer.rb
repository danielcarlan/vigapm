class UserMailer < ActionMailer::Base
  default from: 'noreply@vigap.com'

  def facebook_registration(user)
    @user = user

    mail to: user.email, subject: 'Welcome to Vigap!'
  end

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
end
