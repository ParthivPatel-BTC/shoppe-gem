module Shoppe
  class State < ActiveRecord::Base
    belongs_to :country, :class_name => 'Shoppe::Country'

    self.table_name = 'shoppe_states'

    # Validations
    validates :country_id, :presence => true
    validates :name, :presence => true

    # All states ordered by their name asending
    scope :ordered, -> { order(:name => :asc) }
  end
end
