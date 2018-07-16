class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :date_from
      t.datetime :date_to
      t.references :user, index: true
      t.references :room, index: true
      t.references :hotel, index: true

      t.timestamps null: false
    end
    add_foreign_key :reservations, :users
    add_foreign_key :reservations, :rooms
    add_foreign_key :reservations, :hotels
  end
end
