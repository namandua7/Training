class RemovingTimestamps < ActiveRecord::Migration[7.0]
  def change
    remove_timestamps :doctors
    remove_timestamps :patients
  end
end
