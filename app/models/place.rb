class Place < ApplicationRecord
  enum place_type: [:studio, :small_apartment, :big_apartment, :small_house, :big_house]

  has_one :listing
  has_many :table_joint_place_amenities
  has_many :amenities, through: :table_joint_place_amenities
  
  has_one :landlord, through: :listing
end
