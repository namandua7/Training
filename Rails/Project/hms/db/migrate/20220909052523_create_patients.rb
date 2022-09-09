class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      
      t.string :name
      t.string :gender
      t.string :mobile
      t.date :dob
      t.text :address

      t.timestamps
    end
  end
end