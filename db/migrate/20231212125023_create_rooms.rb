class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.integer :price
      t.integer :minimum_nights
      t.integer :number_of_reviews
      t.float :reviews_per_month
      t.integer :calculated_host_listings_count
      t.integer :availability_365
      t.references :host, null: false, foreign_key: true
      t.references :neighbourhood, null: false, foreign_key: true
      t.references :room_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
