class TableJointPlaceAmenity < ApplicationRecord
  belongs_to :place, foreign_key: 'place_id'
  belongs_to :amenity, foreign_key: 'amenity_id'
end
