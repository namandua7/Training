class AddImageToBlog < ActiveRecord::Migration[7.1]
  def change
    add_column :blogs, :image, :string
  end
end
