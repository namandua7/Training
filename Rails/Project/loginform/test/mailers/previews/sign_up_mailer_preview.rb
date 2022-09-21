# Preview all emails at http://localhost:3000/rails/mailers/sign_up_mailer
class SignUpMailerPreview < ActionMailer::Preview

    def sign_up
        # SignUpMailer.sign_up
        SignUpMailer.with(user: User.first).sign_up 

    end

end
