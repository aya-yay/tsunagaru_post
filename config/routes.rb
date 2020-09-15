Rails.application.routes.draw do
  devise_for :users
  resources :users, only: :show
  resources :audios, only: [:index, :create]
  resources :tweets do
    resources :comments, only: [:index, :create]
  end

  root to: 'comments#index'
end
