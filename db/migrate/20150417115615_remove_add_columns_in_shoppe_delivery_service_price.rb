class RemoveAddColumnsInShoppeDeliveryServicePrice < ActiveRecord::Migration
  def self.up
    remove_column :shoppe_delivery_service_prices, :country_ids
    add_column :shoppe_delivery_service_prices, :country_id, :integer
  end

  def self.down
    remove_column :shoppe_delivery_service_prices, :country_id, :integer
    add_column :shoppe_delivery_service_prices, :country_ids
  end
end
