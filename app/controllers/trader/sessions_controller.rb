class Trader::SessionsController < Trader::Base
  skip_before_action :authorize

  def new
    if current_trader
      redirect_to :trader_root
    else
      @form = Trader::LoginForm.new
      render action: :new
    end
  end

  def create
    @form = Trader::LoginForm.new(login_form_params)
    if @form.email.present?
      trader = Trader.find_by(email: @form.email)
    end
    if trader.present? && trader.password_digest.present? && BCrypt::Password.new(trader.password_digest) == @form.password
      session[:trader_id] = trader.id
      session[:trader_last_access_time] = Time.current
      flash.notice = 'ログインしました。'
      redirect_to :trader_root
    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
      render action: :new
    end
  end

  def destroy
    session.delete(:trader_id)
    flash.notice = 'ログアウトしました。'
    redirect_to :trader_root
  end

  private
    def login_form_params
      params.require(:trader_login_form).permit(:email, :password)
    end
end
