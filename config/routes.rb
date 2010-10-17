ActionController::Routing::Routes.draw do |map|
  map.root :controller => "home", :action => "index"
  map.brand_validation '/brand_validation', :controller => 'brands_status', :action => 'index'
  map.brand_messages '/brands/:id/messages' , :controller => 'brands', :action => 'messages'
  map.brand_page '/brands/:id/brand_page' , :controller => 'brands', :action => 'brand_page'
  map.opinion_page '/opinions/:id/opinion_page' , :controller => 'opinions', :action => 'opinion_page'
  map.resources :brands
  map.opinion '/ccccc', :controller => 'opinions', :action=> 'index', :opinion=> 'aaa'
  map.resources :opinions
  map.resources :expressions
  map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

