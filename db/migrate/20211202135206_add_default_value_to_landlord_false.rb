class AddDefaultValueToLandlordFalse < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :is_landlord, :boolean, :default => false
    change_column :users, :is_admin, :boolean, :default => false
  end
end
