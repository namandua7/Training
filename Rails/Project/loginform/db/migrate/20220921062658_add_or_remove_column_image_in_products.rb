class AddOrRemoveColumnImageInProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :images, :blob
    remove_column :products, :image
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end