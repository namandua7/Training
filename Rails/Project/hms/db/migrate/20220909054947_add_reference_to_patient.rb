class AddReferenceToPatient < ActiveRecord::Migration[7.0]
  def change
    add_reference :patients, :doctor, index: false
  end
end
