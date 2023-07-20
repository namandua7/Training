class ChangeColumnNameFromDoctorToDoctorName < ActiveRecord::Migration[7.0]
  def change
    rename_column :appointments, :doctor, :doctor_name
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
