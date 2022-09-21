class SessionsController < ApplicationController

    def sign_in

        if session[:user_id]
            redirect_to products_path, notice: "User signed in already"
        elsif admin_signed_in?
            redirect_to products_path, notice: "Admin signed in already"
        end

    end

    def new

        # render 'admins/sessions/new'

    end

    def create

        @user = User.find_by_email_and_password(params[:email],params[:password])

        if @user.present? #&& user.authenticate(params[:password])
            session[:user_id]=@user.id
            redirect_to products_path, notice: "Logged in successfuly"
        else
            redirect_to sessions_sign_in_path, notice: "Invalid email or password"
        end
        
    end

    def show
        render 'sign_in'
    end

    def destroy
        session[:user_id] = nil
        redirect_to sessions_sign_in_path
    end

end
