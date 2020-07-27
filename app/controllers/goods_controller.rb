class GoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_diary

  def create
    @good = current_user.goods.find_or_create_by!(diary: @diary)
    NotificationMailer.send_good(@good).deliver_later
  end

  def destroy
    @good = current_user.goods.find_by(diary: @diary)
    @good.destroy if @good.present?
  end

  private
    def set_diary
      @diary = Diary.find(params[:diary_id])
    end
end
