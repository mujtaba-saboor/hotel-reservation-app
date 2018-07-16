class RemoveTypeFromRoom < ActiveRecord::Migration
  def change
    remove_column :rooms, :type, :string
  end
end
