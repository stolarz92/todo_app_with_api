class ListItemsController < ApplicationController
  before_action :set_todo_list

  # POST /list_items
  # POST /list_items.json
  def create
    @todo_item = @todo_list.todo_items.create(todo_item_params)
    redirect_to @todo_list
  end

  private
    def set_todo_list
      @todo_list = TodoList.find(params[:todo_list_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_item_params
      params[:list_item].permit(
                          :name,
                          :description,
                          :completed,
                          :todo_list_id
                        )
    end
end
