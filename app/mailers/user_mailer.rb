class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    send_mail(@user.email, 'Welcome to TestBlog! Share to Care', mandrill_template("welcome_email", {"NAME"  => user.full_name}))
  end

end
