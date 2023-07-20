class Appointment < ApplicationRecord

    validates :appointment_date, :appointment_time, :doctor_name, :disease, presence: true

    belongs_to :doctor
    belongs_to :patient

    after_create_commit {broadcast_prepend_to "appointments"}
    after_update_commit {broadcast_replace_to "appointments"}
    after_destroy_commit {broadcast_remove_to "appointments"}

end