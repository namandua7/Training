class AddNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :name, :string
    add_column :admins, :mobile, :string
  end
end
