module ApplicationHelper
  def active_class(link_path, root = false)
    if current_page?(link_path) || current_page?(root_path) && root
      "menu-active"
    else
      ""
    end
  end
end
