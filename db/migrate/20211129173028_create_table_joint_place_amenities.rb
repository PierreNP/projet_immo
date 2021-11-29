class CreateTableJointPlaceAmenities < ActiveRecord::Migration[6.1]
  def change
    create_table :table_joint_place_amenities do |t|
      t.belongs_to :place
      t.belongs_to :amenity

      t.timestamps
    end
  end
end
