PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :posts do
    resources :comments, only: [:create, :edit, :update]
  end

  resources :categories, only: [:new, :create, :show]
  resources :users, except: :new
end
