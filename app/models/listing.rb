class Listing < ApplicationRecord
  belongs_to :landlord, class_name: "User", foreign_key: 'user_id'

  has_many :table_joint_listing_categories
  has_many :categories, through: :table_joint_listing_categories
end
