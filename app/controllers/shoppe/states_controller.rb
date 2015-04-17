module Shoppe
  class StatesController < ApplicationController

    before_filter { @active_nav = :states }
    before_filter { params[:id] && @state = Shoppe::State.find(params[:id]) }

    def index
      @states = Shoppe::State.ordered
    end

    def new
      @state = Shoppe::State.new
    end

    def create
      @state = Shoppe::State.new(safe_params)
      if @state.save
        redirect_to :states, :flash => {:notice => t('shoppe.states.create_notice')}
      else
        render :action => "new"
      end
    end

    def edit
    end

    def update
      if @state.update(safe_params)
        redirect_to [:edit, @state], :flash => {:notice => t('shoppe.states.update_notice') }
      else
        render :action => "edit"
      end
    end

    def destroy
      @state.destroy
      redirect_to :states, :flash => {:notice => t('shoppe.states.destroy_notice')}
    end


    private

    def safe_params
      params[:state].permit(:name, :code2, :country_id)
    end

  end
end
