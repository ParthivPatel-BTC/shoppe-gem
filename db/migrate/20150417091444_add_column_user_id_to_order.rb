class AddColumnUserIdToOrder < ActiveRecord::Migration
  def change
    add_column :shoppe_orders, :user_id, :integer
  end
end
