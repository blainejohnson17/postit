PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  post '/posts/:id/vote', to: 'posts#vote', as: 'vote_post'
  post '/comments/:id/vote', to: 'comments#vote', as: 'vote_comment'

  resources :posts do
    resources :comments, only: [:create, :edit, :update]
  end

  resources :categories, only: [:show, :new, :create, :edit, :update]
  resources :users, except: :new


end