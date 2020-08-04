class Trader::Base < ApplicationController
  before_action :authorize
  before_action :check_timeout

  helper_method :current_trader
  helper_method :trader_signed_in?

  private
    def current_trader
      if session[:trader_id]
        @current_trader ||= Trader.find_by(id: session[:trader_id])
      end
    end

    def trader_signed_in?
      current_trader.present?
    end

    def authorize
      unless current_trader
        flash.alert = '事業者としてログインしてください。'
        redirect_to :trader_login
      end
    end

    def check_timeout
      if current_trader && session[:trader_last_access_time]
        # セッションタイムアウト60分
        if session[:trader_last_access_time] >= 60.minutes.ago
          session[:trader_last_access_time] = Time.current
        else
          session.delete(:trader_id)
          flash.alert = 'セッションがタイムアウトしました。'
          redirect_to :trader_login
        end
      end
    end
end
