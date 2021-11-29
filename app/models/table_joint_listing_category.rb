class TableJointListingCategory < ApplicationRecord
  belongs_to :category
  belongs_to :listing
end
