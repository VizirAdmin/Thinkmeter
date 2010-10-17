class OpinionsController < ApplicationController
  def index
    @opinions = Opinion.unclassified
  end
  
  def edit
    @opinion = Opinion.find(params[:id], :include => [:expressions])
  end
  
  def update
    @opinion = Opinion.find(params[:id], :include => [:expressions])

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
