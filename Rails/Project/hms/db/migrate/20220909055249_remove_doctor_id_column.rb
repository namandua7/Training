class RemoveDoctorIdColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :patients, :doctor_id
  end
end
