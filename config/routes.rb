Rails.application.routes.draw do
  devise_for :users
  resources :audios, only: [:index, :create]
  resources :tweets do
    collection do
      get 'search'
      get 'tweet_search'
    end
    resources :comments, only: [:index, :create]
  end
  resources :users

  root to: 'tweets#top'
end
