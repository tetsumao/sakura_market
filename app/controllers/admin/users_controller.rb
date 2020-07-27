class Admin::UsersController < Admin::Base
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.order(id: :asc).page(params[:page]).per(20)
  end

  def show
  end

  def edit
  end

  def update
    ups = user_params
    ups.delete(:password) if ups.has_key?(:password) && ups[:password].empty?
    if @user.update(ups)
      redirect_to admin_users_url, notice: 'ユーザを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_url, notice: 'ユーザを削除しました。'
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :user_name, :zip, :address, :nickname, :picture)
    end
end
