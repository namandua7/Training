class UsingReversible < ActiveRecord::Migration[7.0]
  def change
    reversible do |t|
      t.up do
        add_timestamps :appointments
      end
      t.down do
        remove_timestamps :appointments
      end
    end
  end
end
