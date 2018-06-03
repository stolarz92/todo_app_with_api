module Api
  module V1
    class ListItemsController < ApiBaseController
      def complete
        id = params[:id]
        list_item = ListItem.find(params[:id])
        if list_item
          list_item.toggle_complete
          render json: {
              data: {
                  id: list_item.id.to_s,
                  type: 'list-items',
                  attributes: list_item.as_json
              }
            }, status: 200
        else
          render json: {
              data: {
                  error: {
                      message: "Record with id #{id} not found",
                  }
              }
          }, status: 404
        end
      end
    end
  end
end
