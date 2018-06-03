Rails.application.routes.draw do
  get 'static_pages/homepage'

  get 'static_pages/about'

  get 'static_pages/contact'

  devise_for :users
  resources :todo_lists do
    resources :list_items do
      member do
        patch :complete
      end
    end
  end

  root 'static_pages#homepage'
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
      jsonapi_resources :todo_lists
      jsonapi_resources :list_items do
        member do
          patch :complete
        end
      end
    end
  end
end
