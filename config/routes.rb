Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :categories, except: :index, module: 'publications'
  resources :posts, module: 'publications' do
    resources :comments, except: [:index, :show] do
      resources :votes, only: [:create, :destroy]
    end
  end
  resources :tags, only: :show, module: 'publications'
end
