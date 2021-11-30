class Amenity < ApplicationRecord
  has_many :table_joint_place_amenities
  has_many :places, through: :table_joint_place_amenities
end
