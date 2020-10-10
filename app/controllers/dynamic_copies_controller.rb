class DynamicCopiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:get_by_key]

  def index
    @copies = DynamicCopy.all
  end

  def get_by_key
    key = params[:key]
    @copy = DynamicCopy.find_by(key: key)
  end

  def new
    @copy = DynamicCopy.new
  end

  def edit
    @copy = DynamicCopy.find(params[:id])
  end

  def update
    @copy = DynamicCopy.find(params[:id])

    if @copy.update(dynamic_copies_params)
      redirect_to dynamic_copies_url, notice: 'Copy successfully updated.'
    else
      render :edit
    end
  end

  def create
    @copy = DynamicCopy.new(dynamic_copies_params)

    if @copy.save
      redirect_to dynamic_copies_url, notice: 'Copy successfully added.'
    else
      render :new
    end
  end

  private
  def dynamic_copies_params
    params.require(:dynamic_copy).permit(:key, :copy)
  end
end
