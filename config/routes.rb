Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "users/registrations" }
  root to: 'books#index'

  resources :users, only: %i[index show] do
    resource :relationships, only: %i[create destroy]
    scope module: :users do
      resources :followings, only: [:index]
      resources :followers, only: [:index]
    end
  end

  resources :posts

  resources :posts do
    resources :comments, only: %i[create edit update destroy], module: :posts
  end

  resources :books

  resources :books do
    resources :comments, only: %i[create edit update destroy], module: :books
  end

end