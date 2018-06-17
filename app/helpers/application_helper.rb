module ApplicationHelper
  def active_class(link_path)
    if current_page?(link_path) || current_page?(root_path)
      "menu-active"
    else
      ""
    end
  end
end
