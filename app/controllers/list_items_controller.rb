class ListItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_list_item, except: [:create]


  # POST /list_items
  # POST /list_items.json
  def create
    @todo_item = @todo_list.list_items.create(list_item_params)
    redirect_to @todo_list
  end

  def destroy
    @list_item = @todo_list.list_items.find(params[:id])
    if @list_item.destroy
      flash[:success] = "List item was deleted."
    else
      flash[:error] = "List item could not be deleted."
    end
    redirect_to @todo_list
  end

  def complete
    if @list_item.completed?
      @list_item.update_attribute(:completed, nil)
      redirect_to @todo_list, notice: 'List item uncompleted'
    else
      @list_item.update_attribute(:completed, Time.now)
      redirect_to @todo_list, notice: 'List item completed'
    end
  end

  private
    def set_todo_list
      @todo_list = TodoList.find(params[:todo_list_id])
    end

    def set_list_item
      @list_item = @todo_list.list_items.find(params[:id])
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
