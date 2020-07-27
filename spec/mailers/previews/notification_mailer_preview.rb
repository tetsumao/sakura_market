# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  def send_comment
    comment = Comment.last
    NotificationMailer.send_comment(comment)
  end

  def send_good
    good = Good.last
    NotificationMailer.send_good(good)
  end
end
