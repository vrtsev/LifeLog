class UserMailer < ApplicationMailer
  default from: 'notification@lifelog.com.ua'

  def notify_follower(follower, post_author, post)
    @follower    = follower
    @post_author = post_author
    @post        = post
    @url         = 'http://localhost:3000/off_notify'

    subject = "#{@user.name} создал новую запись"
    send_mail(@follower.email, subject)
  end

  def notify_post_author(commenter, post_author, comment)
    @commenter   = commenter
    @post_author = post_author
    @comment     = comment
    @url         = 'http://localhost:3000/off_notify'

    subject = "#{@commenter.name} прокомментировал Вашу запись"
    send_mail(@post_author.email, subject)
  end

  private

  def send_mail(receiver, subject)
    mail(to: receiver, subject: subject)
  end
end
