class BrandsOpinion < ActiveRecord::Base
  belongs_to :opinion
  belongs_to :brand
end
