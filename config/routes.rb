# frozen_string_literal: true

Rails.application.routes.draw do
  resources :friends, only: %i[create]
  resources :users, only: %i[new create]
  resources :tutorials, only: %i[show]
  resources :user_videos, only: %i[create]

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/register', to: 'users#new'
  get '/invite', to: 'invite#new'
  post '/invite', to: 'invite#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'github/sessions#update'
  get '/dashboard', to: 'users#show'

  namespace :api do
    namespace :v1 do
      resources :tutorials, only: %i[show index]
      resources :videos, only: [:show]
    end
  end

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    resources :tutorials, only: %i[create edit update new] do
      resources :videos, only: [:create]
    end
    resources :videos, only: %i[edit update]
    namespace :api do
      namespace :v1 do
        put 'tutorial_sequencer/:tutorial_id', to: 'tutorial_sequencer#update'
      end
    end
  end

  namespace :user do
    get '/activation/:user_id', to: 'activation#update', as: 'activation'
  end
end
