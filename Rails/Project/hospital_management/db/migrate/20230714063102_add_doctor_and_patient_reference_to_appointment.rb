class AddDoctorAndPatientReferenceToAppointment < ActiveRecord::Migration[7.0]
  def change
    add_reference :appointments, :doctor, index: true
    add_foreign_key :appointments, :doctors
    add_reference :appointments, :patient, index: true
    add_foreign_key :appointments, :patients
  end
end
