class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.boolean :house
      t.boolean :studio
      t.boolean :t2
      t.boolean :t3
      t.boolean :garden
      t.boolean :balcony
      t.boolean :swimming_pool
      t.boolean :elevator
      t.boolean :concierge
      t.boolean :terrace
      t.integer :story

      t.timestamps
    end
  end
end
