class PlaceSerializer < ActiveModel::Serializer
  attributes :id, :place_type, :surface, :story
end
