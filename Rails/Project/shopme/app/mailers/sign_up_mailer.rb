class SignUpMailer < ApplicationMailer

    def sign_up

        @user = params[:user]
        @greetings = "Hello, "
        mail(
            to: @user.email,
            subject: "Welcome mail"
        ) 
        
    end

end
