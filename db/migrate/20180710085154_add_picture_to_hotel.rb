class AddPictureToHotel < ActiveRecord::Migration
  def change
    add_column :hotels, :picture, :string
  end
end
