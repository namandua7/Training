class ChangeCategoryDatatype < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.remove :category
      t.string :category
    end
  end
end
