module Shoppe
  class State < ActiveRecord::Base
    belongs_to :country, :class_name => 'Shoppe::Country'

    # All states ordered by their name asending
    scope :ordered, -> { order(:country_id => :asc) }
  end
end
