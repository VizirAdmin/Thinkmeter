# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  include GoogleVisualization

  def list_tags(tags, type)
    result = ""
    tags.each do |tag|
      case type 
        when "opinion"
          result += "<li class='#{tag[:class]}'>#{link_to tag[:tag], opinion_page_path(tag[:id])}</li>\n"
        when "brand"
          result += "<li class='#{tag[:class]}'>#{tag[:tag]}</li>\n"        
#          result += "<li class='#{tag[:class]}'>#{link_to tag[:tag], brand_page_path(tag[:id])}</li>\n"
        else
          result += "<li class='#{tag[:class]}'>#{tag[:tag]}</li>\n"        
      end
    end
    result
  end
end

