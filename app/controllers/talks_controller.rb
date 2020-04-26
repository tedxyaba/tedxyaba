class TalksController < ApplicationController
  def index
    @talks = Talk.includes(:speaker).published
  end
end
