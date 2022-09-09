class AddingReferenceToAppointment < ActiveRecord::Migration[7.0]
  def change
    add_reference :appointments , :patient, index: false
  end
end
