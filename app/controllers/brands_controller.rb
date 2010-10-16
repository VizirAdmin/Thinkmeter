class BrandsController < ApplicationController
  def index
    @brands = Brand.not_validated
  end
  
  def new 
  end
  
  def create
  end
  
  def edit
    @brand = Brand.find(params[:id])
  end
  
  def update
    @brand = Brand.find(params[:id])
    respond_to do |format|
      if @brand.update_attributes(params[:brand])
        format.html { redirect_to(brands_url, :notice => I18n.t('evento.atualizacao_realizada')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end

  end

  def validate
    @brand = Brand.find(params[:id])
    change_status @brand, Brand::VALID
    render "validate.rjs"
  end

  def invalidate
    @brand = Brand.find(params[:id])
    change_status @brand, Brand::INVALID
    render "validate.rjs"
  end

private
  def change_status(brand, status)  
    brand.status = status
    brand.save
  end
end
