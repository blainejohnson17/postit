PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :posts do
    member do
      post 'vote'
    end

    resources :comments, only: [:create, :edit, :update]
      member do
        post 'vote'
      end
  end

  resources :categories, only: [:new, :create, :show]
  resources :users, except: :new


end
