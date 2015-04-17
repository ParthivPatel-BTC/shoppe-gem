class AddStateIdColumnIntoShoppeTaxRates < ActiveRecord::Migration
  def self.up
    add_column :shoppe_tax_rates, :state_id, :integer
  end

  def down
    remove_column :shoppe_tax_rates, :state_id
  end
end
