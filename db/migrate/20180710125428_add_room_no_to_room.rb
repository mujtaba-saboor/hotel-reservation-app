class AddRoomNoToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :room_no, :integer
  end
end
