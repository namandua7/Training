class UsersController < ApplicationController

    def index

    end
    
    def show

    end

    def sign_up

        if session[:user_id]
            redirect_to root_path
        end

        @user = User.new
    end
    
    def create

        @user = User.new(user_params)

        if @user.save
            SignUpMailer.with(user: @user).sign_up.deliver_later 
            session[:user_id] = @user.id 
            redirect_to root_path, notice: "Successfully created"
        else
            render 'sign_up', status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :mobile, {:category => []}, :email, :password, :password_confirmation)
    end

end