class Amenity < ApplicationRecord
  has_many :table_joint_place_amenities, foreign_key: 'amenity_id', dependent: :destroy, inverse_of: "amenity"
  has_many :places
end
