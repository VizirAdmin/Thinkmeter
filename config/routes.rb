ActionController::Routing::Routes.draw do |map|
  map.root :controller => "home", :action => "index"
  map.brand_validation '/brand_validation', :controller => 'brands_status', :action => 'index'
  map.brand_messages '/brands/:id/messages' , :controller => 'brands', :action => 'messages'
  map.graph_by_tag '/opinions/:id/graph_by_tag' , :controller => 'opinions', :action => 'graph_by_tag'
  map.resources :brands
  map.opinion '/ccccc', :controller => 'opinions', :action=> 'index', :opinion=> 'aaa'
  map.resources :opinions
  map.resources :expressions  
  map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

