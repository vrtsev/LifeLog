class UserMailer < ApplicationMailer
  default from: 'notification@lifelog.com.ua'

  def notify_follower(follower, user, post)
    @follower = follower
    @user     = user
    @post     = post
    @url      = 'http://localhost:3000/off_notify'

    mail(to: @follower.email, subject: "#{@user.name} создал новую запись")
  end
end
