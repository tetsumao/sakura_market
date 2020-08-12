class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
  end

  def register_card
    url = params[:redirect_url]
    url = user_path if url.blank?
    if @user.register_card(params[:stripe_token])
      redirect_to url, notice: 'カード情報を登録しました。'
    else
      redirect_to url, alert: 'カード情報が登録できませんでした。'
    end
  end

  def delete_card
    num = @user.delete_card
    if num >= 0
      redirect_to user_path, notice: ((num > 0) ? 'カード情報を削除しました。' : 'カード情報がありません。')
    else
      redirect_to user_path, alert: 'カード情報が削除できませんでした。'
    end
  end

  private
    def set_user
      @user = current_user
    end
end
