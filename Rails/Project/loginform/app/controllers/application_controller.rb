class ApplicationController < ActionController::Base

    add_flash_types :alert, :notice
    
    include Pagy::Backend
    protect_from_forgery with: :exception

    before_action :update_allowed_parameters, if: :devise_controller?

    protected

    def update_allowed_parameters

        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :mobile, :email, :password, :password_confirmation)}
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :mobile, :email, :password, :current_password)}

    end
     
end
