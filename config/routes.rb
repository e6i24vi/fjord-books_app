Rails.application.routes.draw do

  get 'users/index'
  get 'users/show'
  root 'welcome#index'
  devise_for :users, :controllers =>{
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  resources :users, :only => [:index, :show]
  get 'welcome/index'

  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
