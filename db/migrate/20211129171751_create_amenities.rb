class CreateAmenities < ActiveRecord::Migration[6.1]
  def change
    create_table :amenities do |t|
      t.boolean :has_swimming_pool
      t.boolean :has_garden
      t.boolean :has_balcony
      t.boolean :has_terrace
      t.boolean :has_elevator
      t.boolean :has_concierge
      t.boolean :is_last_floor

      t.timestamps
    end
  end
end
