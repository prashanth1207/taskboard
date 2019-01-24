Rails.application.routes.draw do
  apipie
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :taskboard do
    scope :api, defaults: { formats: :json } do
      namespace :v1 do
        post '/login', to: 'users#login'
        post '/signup', to: 'users#create'
        resources :users, only: [:index]
        resources :lists do
          get 'list_members', on: :member
          post 'assign_members', on: :member
          post 'unassign_members', on: :member
          resources :cards
        end
        resources :comments
      end
    end
  end
end
