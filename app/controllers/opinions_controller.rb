class OpinionsController < ApplicationController
  def index
    conn = ActiveRecord::Base.connection
    result=conn.execute("select b.name as name, count(*) as ct
        from opinions o inner join brands_opinions bo on o.id=bo.opinion_id
        inner join brands b on b.id=bo.brand_id
        where o.id = 1 group by b.id")
    @arr=[]
    result.each do |brand|
      @arr << [brand[:name],brand[:ct].to_i]
    end
    @arr << [0,0,"teste"]
    @arr << [0,1,15]
    @arr << [1,0,"teste2"]
    @arr << [1,1,66]
    respond_to do |format|
      format.html
      format.xml  { render :xml => @brands }
    end
  end
end

