Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'landing_page#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # PUBLICATIONS
  # own resources
  resources :categories, except: :index, module: 'publications'
  resources :posts, module: 'publications' do
    resources :comments, except: %i[index show] do
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
      resources :tasks, except: %i[index show]
    end
    resources :tags, param: :name, only: :show
    resources :search, only: :index
  end
end
