class Doctor < ApplicationRecord

    # validates :name, presence: true #{ message: "Must be present" }
    # validates :mobile, presence: true #{ message: "Must be present" }
    # validates :status, presence: { message: "Must be present" }

    # validates :password, confirmation: true
    # validates :password_confirmation, presence: true

    # validates :status, inclusion: {in: %w(Available NotAvailable), message: "%{value} is not valid status" }

    # validates :mobile, length: {maximum: 10}

    # validates :mobile, numericality: { only_integer: true }

    # validates :email, uniqueness: true

end
