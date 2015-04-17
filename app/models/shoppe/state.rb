module Shoppe
  class State < ActiveRecord::Base
    belongs_to :country, :class_name => 'Shoppe::Country'

    self.table_name = 'shoppe_states'

    # Validations
    validates :country_id, :presence => true
    validates :name, :presence => true

    # All states ordered by their name asending
    scope :ordered, -> { order(:name => :asc) }
    scope :get_canada_states, -> { where(country_id: Shoppe::Country.find_by_code2('CA')) }
    scope :find_country_wise_states, -> (country_id) { where(country_id: country_id ) }
  end
end
