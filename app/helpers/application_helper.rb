# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  include GoogleVisualization

  def list_tags(tags)
    result = ""
    tags.each do |tag|
      result += "<li class='#{tag[:class]}'>#{tag[:tag]}</li>\n"
    end
    result
  end
end

