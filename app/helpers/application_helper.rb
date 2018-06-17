module ApplicationHelper
  def active_class(link_path, root = false)
    if current_page?(link_path) ||
       current_page?(root_path) && root ||
       link_path.include?('todo_lists') && request.controller_class == TodoListsController
      "menu-active"
    else
      ""
    end
  end
end
