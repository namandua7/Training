class Appointment < ApplicationRecord

    belongs_to :patient
    belongs_to :doctor

    validates :appointment_date ,presence: true
    validates :start_time ,presence: true
    validates :end_time ,presence: true
    validates :status ,presence: true
    validates :patient_id ,presence: true
    validates :doctor_id ,presence: true
    
end
