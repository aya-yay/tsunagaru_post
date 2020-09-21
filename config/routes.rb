Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }

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
