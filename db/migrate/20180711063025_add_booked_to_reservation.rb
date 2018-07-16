class AddBookedToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :booked, :boolean
  end
end
