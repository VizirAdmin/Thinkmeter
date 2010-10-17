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

  def show
    @brand = Brand.find(params[:id])
    @brand_data_for_chart = Brand.get_brand_per_opinions(params[:id].to_i)
    @brand_count = @brand.messages.count
    @brand_opinions= Opinion.find_all_with_tags_by_brand(:context => @brand.id)
    @positives_messages = @brand.messages.positives
    @negatives_messages = @brand.messages.negatives
    @positive_opinion_count=@positives_messages.size
    @negative_opinion_count=@negatives_messages.size
    total = @positive_opinion_count + @negative_opinion_count
    if total == 0
      @acceptance =50
    else
      @acceptance = ((@positive_opinion_count - @negative_opinion_count).to_i.div total) * 50 + 50
    end
  end

  def validate
    @brand = Brand.find(params[:id])
    change_status @brand, Brand::VALID
    render "classify.rjs"
  end

  def invalidate
    @brand = Brand.find(params[:id])
    change_status @brand, Brand::INVALID
    render "classify.rjs"
  end

  def messages
    @brand = Brand.find(params[:id])
    @positives_messages = @brand.messages.positives
    @negatives_messages = @brand.messages.negatives
  end

private
  def change_status(brand, status)
    brand.status = status
    brand.save
  end
end

