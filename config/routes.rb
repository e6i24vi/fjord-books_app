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

  get 'users/:id/profile',to: 'users#show', as: 'user_profile'

  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

end
