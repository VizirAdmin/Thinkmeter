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
    render "validate.rjs"
  end

  def negative
    @opinion = Opinion.find(params[:id], :include => [:expressions])
    change_status @opinion, Opinion::BAD
    render "validate.rjs"
  end

  def delete
    @opinion = Opinion.find(params[:id], :include => [:expressions])
    @opinion.delete
    render "validate.rjs"
  end

private
  def change_status(opinion, classification)  
    opinion.classification = classification
    opinion.save
  end
end
