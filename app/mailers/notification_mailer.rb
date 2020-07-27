class NotificationMailer < ApplicationMailer
  def send_comment(comment)
    @comment = comment
    mail subject: "コメントが登録されました", to: @comment.diary.user.email do |format|
      format.text
    end
  end

  def send_good(good)
    @good = good
    mail subject: "Good!が付きました", to: @good.diary.user.email do |format|
      format.text
    end
  end
end
