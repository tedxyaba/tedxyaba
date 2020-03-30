class TalksController < ApplicationController
  def index
    @talks = Talk.all
    #todo: add filtering
  end
end
