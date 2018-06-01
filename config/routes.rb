Rails.application.routes.draw do
  devise_for :users
  resources :todo_lists do
    resources :list_items do
      member do
        patch :complete
      end
    end
  end

  root 'todo_lists#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #JSON API
  # namespace 'api' do
  #   namespace 'v1' do
  #     jsonapi_resources :todo_lists
  #     jsonapi_resources :list_items
  #   end
  # end

  namespace :api do
    namespace :v1 do
      jsonapi_resources :todo_lists do
        jsonapi_resources :list_items do
          member do
            patch :complete
          end
        end
      end
    end
  end
end
