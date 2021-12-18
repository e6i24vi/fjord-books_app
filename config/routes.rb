Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "users/registrations" }
  root to: 'books#index'
  resources :books
  resources :users, only: %i(index show)
  resources :users do
    resource :followingrelationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
  end
end
