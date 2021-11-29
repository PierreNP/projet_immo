class CategorySerializer < ActiveModel::Serializer
  attributes :id, :house, :studio, :t2, :t3, :garden, :balcony, :swimming_pool, :elevator, :concierge, :terrace, :story
end
