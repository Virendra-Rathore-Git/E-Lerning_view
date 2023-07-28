class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url  = 'http://Google.com'
    # attachments.inline["1kb.png"] = File.read("#{Rails.root}/app/assets/Image/1kb.png")
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end

