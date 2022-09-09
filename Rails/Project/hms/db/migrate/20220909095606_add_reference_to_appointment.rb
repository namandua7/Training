class AddReferenceToAppointment < ActiveRecord::Migration[7.0]
  def change
    add_reference :appointments, :doctor, index: false, foreign_key: true
  end
end
