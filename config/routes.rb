Rails.application.routes.draw do
  resource :newsletter_subscriptions, only: [:create, :index]
  resources :teams
  resources :partners
  resources :talks, only: [:index]
  resources :events do
    resources :talks, controller: 'event_talks'
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
