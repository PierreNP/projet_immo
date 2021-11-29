class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.belongs_to :landlord, foreign_key: {to_table: :users}, index:true

      t.string :title
      t.text :description
      t.integer :price
      t.integer :status

      t.timestamps
    end
  end
end
