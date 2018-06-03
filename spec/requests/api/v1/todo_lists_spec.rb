require 'rails_helper'

RSpec.describe Api::V1::TodoListsController, type: :request do
  let(:headers) {
    {
      'Content-Type' => 'application/vnd.api+json',
    }
  }
  let!(:user) { create(:user) }
  let!(:todo_lists) { create_list(:todo_list, 10, user_id: user.id) }
  let(:todo_list_id) { todo_lists.first.id }
  let(:type) { model.to_s.pluralize.underscore.dasherize }
  let(:valid_relationships) do
    {
        'user' => {
            data: {
                type: 'users',
                id: user.id.to_s
            }
        }
    }
  end

  before do
    post '/users/sign_in.json',
       params: { "user"=>{ "email"=>"#{user.email}","password"=>"password123" } }.to_json,
       headers: {"Content-Type"=>"application/json" }
    @current_user = User.find_by(email: json['email'])
    @token = JWTWrapper.encode({"user_id"=>@current_user.id})
    @headers = {'Content-Type' => 'application/vnd.api+json', "Authorization"=>"Bearer #{@token}"}
  end

  describe 'GET#index api/v1/todo-lists' do
    before { get '/api/v1/todo-lists', headers: @headers }

    it 'returns todo_lists' do
      expect(json_data).to_not be_empty
      expect(json_data.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET#show api/v1/todo-lists/:id' do
    before { get "/api/v1/todo-lists/#{todo_list_id}", headers: @headers }

    context 'whent the record exists' do
      it 'returns the todo' do
        expect(json_data).not_to be_empty
        expect(json_data['id']).to eq(todo_list_id.to_s)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let (:todo_list_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json_errors[0]['title']).to eq('Record not found')
      end
    end
  end

  describe 'POST#create api/v1/todo-lists' do
    context 'when the request is valid' do
      let(:valid_attributes) { { name: 'New Todo List' } }
      let(:valid_params) do
        {
            data: {
                type: 'todo-lists',
                attributes: valid_attributes,
                relationships: valid_relationships
            }
        }
      end
      let(:post_request) do
        post '/api/v1/todo-lists',
          params: valid_params.to_json,
          headers: @headers
      end

      before { post_request }

      it 'creates a todo list' do
        expect(json_attributes['name']).to eq('New Todo List')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { name: '' } }
      let(:invalid_params) do
        {
            data: {
                type: 'todo-lists',
                attributes: invalid_attributes,
                relationships: valid_relationships
            }
        }
      end
      let(:post_request) do
        post '/api/v1/todo-lists',
          params: invalid_params.to_json,
          headers: @headers
      end

      before { post_request }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json_errors.first['detail'])
            .to eq("name - can't be blank")
      end
    end
  end

  describe 'PUT#update api/v1/todo-lists/:id' do
    let(:valid_attributes) { { name: 'Updated name' } }
    let(:valid_params) do
      {
          data: {
              type: 'todo-lists',
              id: todo_list_id.to_s,
              attributes: valid_attributes,
              relationships: valid_relationships
          }
      }
    end
    let(:put_request) do
      put "/api/v1/todo-lists/#{todo_list_id}" ,
          params: valid_params.to_json,
          headers: @headers
    end

    before { put_request }

    context 'when the todo_list exists' do
      it 'updates the record' do
        updated_item = TodoList.find(todo_list_id)
        expect(updated_item.name).to eq('Updated name')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the todo_list does not exist' do
      let(:todo_list_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json_errors.first['title']).to eq("Record not found")
      end
    end
  end

  describe 'DELETE#destroy api/v1/todo-lists/:id' do
    before { delete "/api/v1/todo-lists/#{todo_list_id}", headers: @headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
