class ExpressionsController < ApplicationController
  def delete
    @expression_id = params[:id]
    @expression = Expression.delete(params[:id])
  end
  
  def create
    opinion_id = params[:opinion_id]
    expression = params[:expression]
    @expression = Expression.create(:opinion_id => opinion_id, :expression => expression)
  end
end
