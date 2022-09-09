class Patient < ApplicationRecord

    has_many :doctors, through: :appointments
    has_many :appointments
    
    # belongs_to :doctor
    # has_many :appointments

    # validates :doctor_id, presence: true
    # validates :name, presence: true #{ message: "Must be present" }
    # validates :mobile, presence: true #{ message: "Must be present" }
    # validates :dob, presence: true #{ message: "Must be present" }

    # validates :mobile, length: {maximum: 10}


end
