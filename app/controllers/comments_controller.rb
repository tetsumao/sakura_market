class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:switch]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      NotificationMailer.send_comment(@comment).deliver_later
    end
  end

  def switch
    @diary = Diary.find(params[:diary_id])
    @open = ActiveModel::Type::Boolean.new.cast(params[:open])
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :diary_id)
    end
end
