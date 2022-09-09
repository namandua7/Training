class AddForeginKeyToAppointment < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :appointments, :patients
  end
end
