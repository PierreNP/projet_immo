class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      t.integer :place_type
      t.integer :surface
      t.integer :story
      t.string :location

      t.timestamps
    end
  end
end
