class TalksController < ApplicationController
  def index
    @talks = Talk.includes(:speaker).all
    #todo: add filtering
  end
end
