class ChangeCountryIdColumnName < ActiveRecord::Migration
  def self.up
    remove_column :shoppe_tax_rates, :country_ids
    add_column :shoppe_tax_rates, :country_id, :integer
  end

  def down
    remove_column :shoppe_tax_rates, :country_id
    add_column :shoppe_tax_rates, :country_ids, :text
  end
end
