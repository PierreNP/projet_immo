class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.text :description
      t.integer :price
      t.integer :surface
      t.string :location
      t.string :title
      t.boolean :status

      t.timestamps
    end
  end
end
