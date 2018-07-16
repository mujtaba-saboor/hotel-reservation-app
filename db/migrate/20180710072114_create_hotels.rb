class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :country
      t.string :city
      t.string :street

      t.timestamps null: false
    end
  end
end
