class AddCategoryToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :category, :string
  end
end
