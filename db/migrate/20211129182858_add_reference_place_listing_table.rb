class AddReferencePlaceListingTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :listings, :place, index: true
  end
end
