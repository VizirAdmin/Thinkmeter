class BrandsStatusController < ApplicationController
  def index
    @brands = Brand.not_validated
  end

  def update
  end
end

