module ApplicationHelper

  # return the title-Tag of a given page
  def title
    base_title = "RoR Tut App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  # return the logo
  def logo
    image_tag("rails.png", :alt => 'Sample App', :class => 'round')
  end


end

