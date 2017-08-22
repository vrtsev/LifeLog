Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'landing_page#index'
  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  get '/news_feed', to: 'news_feed#index'

  get '/about', to: 'info_pages#about'
  get '/contacts', to: 'info_pages#contacts'
  post '/contacts/send_feedback', to: 'info_pages#send_feedback'

  namespace :admin do
    namespace :statistics do
      get '/visits', to: 'statistics#visit'
      get '/events', to: 'statistics#events'
      get '/trackings', to: 'statistics#trackings'
    end
    resources :feedbacks
    resources :users
  end
  
  # PUBLICATIONS
  # own resources
  resources :categories, except: :index, module: 'publications'
  resources :posts, module: 'publications' do
    resources :comments, except: %i[new index show] do
      resources :votes, only: %i[create destroy]
    end
  end
  resources :tags, param: :name, only: :show, module: 'publications'
  resources :search, only: :index, module: 'publications'

  # resources of other people
  resources :users, only: %i[index show], module: 'publications' do
    resources :categories, only: :show, module: 'users'
    resources :posts, only: %i[index show], module: 'users' do
      resources :comments, except: %i[index show] do
        resources :votes, only: %i[create destroy]
      end
    end
    resources :search, only: :index, module: 'users'
    resources :follows, only: %i[create destroy], module: 'users'
  end

  # DIARY
  namespace :diary do
    resources :categories, except: :index
    resources :posts do
      resources :comments, except: %i[index show]
    end
    resources :tags, param: :name, only: :show
    resources :search, only: :index
  end

  # GOALS
  namespace :objectives do
    resources :categories, except: :index
    resources :goals do
      resources :actions
      resources :tasks, except: %i[index show] do
        put :sort, on: :collection
        member do
          patch 'done'
          patch 'undone'
        end
      end
    end
    resources :tags, param: :name, only: :show
    resources :search, only: :index
  end
end
