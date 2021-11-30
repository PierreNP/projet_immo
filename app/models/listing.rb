class Listing < ApplicationRecord
  belongs_to :landlord, class_name: 'User'
  belongs_to :place

  has_many_attached :images
end
