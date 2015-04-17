class ChangeStateNameColumnName < ActiveRecord::Migration
  def self.up
    remove_column :shoppe_states, :state_name
    add_column :shoppe_states, :name, :string
  end

  def down
    remove_column :shoppe_states, :name
    add_column :shoppe_states, :state_name, :string
  end
end
