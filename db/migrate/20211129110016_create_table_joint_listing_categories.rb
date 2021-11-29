class CreateTableJointListingCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :table_joint_listing_categories do |t|
      t.belongs_to :listing
      t.belongs_to :category
      t.timestamps
    end
  end
end
