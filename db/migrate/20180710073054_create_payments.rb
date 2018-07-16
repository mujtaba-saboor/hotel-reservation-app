class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.references :user, index: true
      t.references :reservation, index: true

      t.timestamps null: false
    end
    add_foreign_key :payments, :users
    add_foreign_key :payments, :reservations
  end
end
