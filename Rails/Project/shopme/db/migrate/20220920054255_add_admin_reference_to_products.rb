class AddAdminReferenceToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :admin, index: true
    add_foreign_key :products, :admins
  end
end
