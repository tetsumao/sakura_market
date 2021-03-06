class ApplicationController < ActionController::Base
  layout :set_layout
  before_action :basic_auth, if: :production? 
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :zip, :address, :nickname, :picture])
      devise_parameter_sanitizer.permit(:account_update, keys: [:email, :user_name, :zip, :address, :nickname, :picture])
    end

  private
    def set_layout
      controller = params[:controller]
      if controller.match(%r{\A(admin)/})
        'admin'
      elsif controller.match(%r{\A(trader)/})
        'trader'
      else
        'user'
      end
    end

    def production?
      Rails.env.production?
    end

    def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
      end
    end
end
