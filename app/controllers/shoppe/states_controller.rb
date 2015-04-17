require_dependency "shoppe/application_controller"

module Shoppe
  class StatesController < ApplicationController
    def index
      @states = Shoppe::State.ordered
    end

    def new
      @state = Shoppe::State.new
    end
  end
end
