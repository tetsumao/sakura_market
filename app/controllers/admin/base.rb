class Admin::Base < ApplicationController
  before_action :authorize
  before_action :check_timeout

  helper_method :current_admin
  helper_method :admin_signed_in?

  private
    def current_admin
      if session[:admin_id]
        @current_admin ||= Admin.find_by(id: session[:admin_id])
      end
    end

    def admin_signed_in?
      current_admin.present?
    end

    def authorize
      unless current_admin
        flash.alert = '管理者としてログインしてください。'
        redirect_to :admin_login
      end
    end

    def check_timeout
      if current_admin && session[:admin_last_access_time]
        # セッションタイムアウト60分
        if session[:admin_last_access_time] >= 60.minutes.ago
          session[:admin_last_access_time] = Time.current
        else
          session.delete(:admin_id)
          flash.alert = 'セッションがタイムアウトしました。'
          redirect_to :admin_login
        end
      end
    end
end
