class ListingSerializer < ActiveModel::Serializer
  attributes :id, :description, :price, :surface, :location, :title, :status
  has_one :user_id
end
