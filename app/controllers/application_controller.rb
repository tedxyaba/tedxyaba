class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_access_control_headers
  before_action :format_filters

  private
  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept'
  end

  def format_filters
    params[:filters] ||= {}
    if params[:filters].is_a?(String)
      params[:filters] = JSON.parse(params[:filters])
    end
  end
end
