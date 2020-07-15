class Admin::SessionsController < Admin::Base
  skip_before_action :authorize

  def new
    if current_admin
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Admin::LoginForm.new(login_form_params)
    if @form.login_name.present?
      admin = Admin.find_by(login_name: @form.login_name)
    end
    if admin.present? && admin.password_digest.present? && BCrypt::Password.new(admin.password_digest) == @form.password
      session[:admin_id] = admin.id
      session[:admin_last_access_time] = Time.current
      flash.notice = 'ログインしました。'
      redirect_to :admin_root
    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
      render action: 'new'
    end
  end

  def destroy
    session.delete(:admin_id)
    flash.notice = 'ログアウトしました。'
    redirect_to :admin_root
  end

  private
    def login_form_params
      params.require(:admin_login_form).permit(:login_name, :password)
    end
end
