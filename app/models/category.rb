class Category < ApplicationRecord
  has_many :table_joint_listing_categories
  has_many :listings, through: :table_joint_listing_categories

end
