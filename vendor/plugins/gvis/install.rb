# This file is run when the plugin is installed
puts %Q(
Gvis
====

Ruby wrapper for easily loading the Google Visualization API, and simple generation of the javascript required to plot the graphs


Installation
============

script/plugin install git://github.com/jeremyolliver/gvis.git

# Include the GoogleVisualization module in app/helpers/application_helper.rb
module ApplicationHelper
  
  include GoogleVisualization
  
end

# Load the API, and render any graphs by placing these methods inside your layout
# app/views/layouts/application.html.erb
<head>
	<%= include_visualisation_api %>
	<%= render_visualisations %>
...
</head>

Example
=======

# Render desired graphs in the view
# index.html.erb
<% visualization "my_chart", "MotionChart", :width => 600, :height => 400, :html => {:class => "graph_chart"} do |chart| %>
	<%# Add the columns that the graph will have
	<% chart.string "Fruit" %>
	<% chart.date "Date" %>
	<% chart.number "Sales" %>
	<% chart.number "Expenses" %>
	<% chart.string "Location" %>
	
	<%# Add the data
	<% chart.add_rows([
			["Apples", Date.new(1998,1,1), 1000,300,'East'],
			["Oranges", Date.new(1998,1,1), 950,200,'West'],
			["Bananas", Date.new(1998,1,1), 300,250,'West'],
			["Apples", Date.new(1998,2,1), 1200,400,'East'],
			["Oranges", Date.new(1998,2,1), 950,150,'West'],
			["Bananas", Date.new(1998,2,1), 788,617,'West']
		]) %>
<% end %>


Copyright (c) 2009 [Jeremy Olliver], released under the MIT license
)