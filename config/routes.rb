Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :publications
end
