class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|

      t.date :schedule_date
      t.string :day
      t.time :start_time
      t.time :end_time
      t.string :break

      t.timestamps
    end
  end
end