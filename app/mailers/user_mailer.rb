class UserMailer < ApplicationMailer
  default from: 'example@gmail.com'

  def welcome_email(user)
    @user=user
    mail(to:@user.email, subject: 'welcome to my movie review site')
  end
end
