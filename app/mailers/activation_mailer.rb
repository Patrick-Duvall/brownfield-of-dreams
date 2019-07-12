class ActivationMailer < ApplicationMailer
  def activate(user, user_email)
    @user = user
    mail(to: user_email, subject: "Welcome to Sorrow #{@user.first_name}.")
  end
end
