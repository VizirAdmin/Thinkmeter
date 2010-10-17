class OpinionsController < ApplicationController
  def index
    @opinions = Opinion.unclassified
  end

  def show
    @opinion = Opinion.find(params[:id])
    @opinions_data_for_chart = Opinion.get_opinion_per_brands(params[:id].to_i)
    @opinion_count = @opinion.messages.count
    @opinion_brands =  Opinion.total_of_brands_with_me(@opinion.id).count

  end

  def edit
    @opinion = Opinion.find(params[:id], :include => [:expressions])
  end

  def update
    @opinion = Opinion.find(params[:id], :include => [:expressions])
    respond_to do |format|
      if @opinion.update_attributes(params[:opinion])
        format.html { redirect_to(opinion_url, :notice => I18n.t('evento.atualizacao_realizada')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
    
    #@opinion = Opinion.find(params[:id], :include => [:expressions])
  end

  def positive
    @opinion = Opinion.find(params[:id], :include => [:expressions])
    change_status @opinion, Opinion::GOOD
    render "classify.rjs"
  end

  def negative
    @opinion = Opinion.find(params[:id], :include => [:expressions])
    change_status @opinion, Opinion::BAD
    render "classify.rjs"
  end

  def delete
    @opinion_id = params[:id]
    Opinion.delete(@opinion_id)
    render "delete.rjs"
  end

private
  def change_status(opinion, classification)
    opinion.classification = classification
    opinion.save
  end
end

