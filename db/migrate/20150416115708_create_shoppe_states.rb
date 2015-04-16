class CreateShoppeStates < ActiveRecord::Migration
  def change
    create_table :shoppe_states do |t|
      t.integer :country_id
      t.string :code2
      t.string :state_name
      t.timestamps null: false
    end
  end
end
