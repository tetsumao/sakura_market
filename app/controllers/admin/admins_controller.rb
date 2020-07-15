class Admin::AdminsController < Admin::Base
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  def index
    @admins = Admin.default_order.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @admin = Admin.new
    @admin.dspo = Admin.next_dspo
  end

  def edit
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to admin_admins_url, notice: '管理者を作成しました。'
    else
      render :new
    end
  end

  def update
    aps = admin_params
    aps.delete(:password) if aps.has_key?(:password) && aps[:password].empty?
    if @admin.update(aps)
      redirect_to admin_admins_url, notice: '管理者を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @admin.destroy
    redirect_to admin_admins_url, notice: '管理者を削除しました。'
  end

  private
    def set_admin
      @admin = Admin.find(params[:id])
    end

    def admin_params
      params.require(:admin).permit(:login_name, :password, :admin_name, :dspo)
    end
end
