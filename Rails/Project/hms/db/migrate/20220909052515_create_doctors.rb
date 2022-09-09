class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      
      t.string :name
      t.string :mobile
      t.string :gender
      t.string :email
      t.string :password
      t.string :status

      t.timestamps
    end
  end
end
