require 'rails_helper'

RSpec.describe Api::V1::ListItemsController, type: :request do
  let!(:user) { create(:user) }
  let!(:todo_list) { create(:todo_list,
                            user_id: user.id) }
  let(:todo_list_id) { todo_list.id }
  let!(:list_items) { create_list(:list_item, 20,
                                 todo_list: todo_list) }
  let(:list_item_id) { list_items.first.id }
  let(:valid_relationships) {
    {
      'todo-list' => {
        data: {
          type: 'todo-lists',
          id: todo_list_id.to_s
        }
      }
    }
  }

  before do
    post '/users/sign_in.json',
         params: { "user"=>{ "email"=>"#{user.email}","password"=>"password123" } }.to_json,
         headers: {"Content-Type"=>"application/json" }
    @current_user = User.find_by(email: json['email'])
    @token = JWTWrapper.encode({"user_id"=>@current_user.id})
    @headers = {'Content-Type' => 'application/vnd.api+json', 'Authorization'=>"Bearer #{@token}"}
  end

  describe 'GET#index api/v1/todo-lists' do
    before { get "/api/v1/list-items", headers: @headers }

    context 'when todo_list exists' do
      it 'returns list items' do
        expect(json_data).to_not be_empty
        expect(json_data.size).to eq(20)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET#show api/v1/list-items/:id' do
    before { get "/api/v1/list-items/#{list_item_id}", headers: @headers }

    context 'when list_item exists' do
      it 'returns list item' do
        expect(json_data['id']).to eq(list_item_id.to_s)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when list_item does not exist' do
      let(:list_item_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json_errors[0]['title']).to eq('Record not found')
      end
    end
  end

  describe 'POST#create api/v1/list-items' do
    context 'when request attributes are valid' do
      let(:valid_attributes) { { name: 'New name' } }

      let(:valid_params) do
        {
            data: {
                type: 'list-items',
                attributes: valid_attributes,
                relationships: valid_relationships
            }
        }
      end

      let(:post_request) do
        post "/api/v1/list-items/",
             params: valid_params.to_json,
             headers: @headers
      end

      before { post_request }

      it 'creates a list item' do
        expect(json_attributes['name']).to eq('New name')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      let(:invalid_attributes) { { name: '' } }

      let(:invalid_params) do
        {
            data: {
                type: 'list-items',
                attributes: invalid_attributes,
                relationships: valid_relationships
            }
        }
      end

      let(:post_request) do
        post "/api/v1/list-items/",
             params: invalid_params.to_json,
             headers: @headers
      end

      before { post_request }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(json_errors.first['detail']).to eq("name - can't be blank")
      end
    end
  end

  describe 'PUT#update api/v1/list-items/:id' do
    let(:valid_params) do
      {
        data: {
          type: 'list-items',
          id: list_item_id.to_s,
          attributes: { name: 'Updated name' },
        }
      }
    end

    let(:put_request) do
      put "/api/v1/list-items/#{list_item_id}",
           params: valid_params.to_json,
           headers: @headers
    end

    before { put_request }

    context 'when the item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the item' do
        updated_item = ListItem.find(list_item_id)
        expect(updated_item.name).to eq('Updated name')
      end
    end

    context 'when the item does not exist' do
      let(:list_item_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json_errors.first['title']).to eq("Record not found")
      end
    end
  end

  describe 'DELETE#destroy /api/v1/list-item/:id' do
    before { delete "/api/v1/list-items/#{list_item_id}", headers: @headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
