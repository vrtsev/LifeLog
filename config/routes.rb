Rails.application.routes.draw do
  root 'welcome#index'
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
      resources :comments, except: %i[index show] #do
        # resources :votes, only: [:create, :destroy]
      # end
    end
    # resources :tags, param: :name, only: :show, module: 'publications'
    # resources :search, only: :index, module: 'publications'
  end
end
