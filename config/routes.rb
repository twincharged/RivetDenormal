Rails.application.routes.draw do
  devise_for :users

# , path: '/', constraints: {subdomain: 'api'}

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users do   # param: :username  # add this to user resources to index users & their routes by their username
        member do
          get '/profile', to: 'users#profile'
          get '/following', to: 'users#following'
          get '/followers', to: 'users#followers'
          get '/conversations', to: 'conversations#user_conversations'
          get '/groups', to: 'groups#user_groups'
          get '/events', to: 'events#user_events'
          get '/added_events', to: 'events#added_user_events'
          get '/invited_events', to: 'events#invited_user_events'
          get '/blocked_user_ids', to: 'users#blocked_user_ids'
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
