class ApplicationController < ActionController::Base
    before_action :update_allowed_parameters, if: :devise_controller?
    protected
    def update_allowed_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :mobile, :email, :password, :password_confirmation)}
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :mobile, :email, :password, :current_password)}
    end
    def after_sign_in_path_for(resource_or_scope)
        blogs_path    
    end
      
    def after_sign_out_path_for(resource_or_scope)
        new_user_session_path
    end
end
