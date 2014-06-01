Rails.application.routes.draw do
  devise_for :users

# , path: '/', constraints: {subdomain: 'api'}

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users do
        member do
          get '/posts', to: 'users#posts'
          get '/following/', to: 'users#following'
          get '/followers/', to: 'users#followers'
          resources :conversations do
            member do
             get '/messages', to: 'conversations#show'
            end
          end
        end
      end
        # devise_scope :user do
        #   match '/sessions', to: 'sessions#create', via: :post
        #   match '/sessions', to: 'sessions#destroy', via: :delete
        # end
        # resources :record
        # resources :users, only: [:create]
        # match '/users', to: 'users#show', via: :get
        # match '/users', to: 'users#update', via: :put
        # match '/users', to: 'users#destroy', via: :delete
    end
  end

end
