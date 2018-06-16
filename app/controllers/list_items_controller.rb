class ListItemsController < ApplicationController
  before_action :authenticate_user!
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
      flash[:success] = "Zadanie usunięte."
    else
      flash[:error] = "Zadanie nie mogło zostac usunięte."
    end
    redirect_to @todo_list
  end

  def complete
    @list_item.toggle_complete

    if @list_item.completed?
      redirect_to @todo_list, notice: 'Zadanie oznaczone jako wykonane.'
    else
      redirect_to @todo_list, notice: 'Zadanie oznaczone jako niewykonane.'
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
