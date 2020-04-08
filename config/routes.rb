Rails.application.routes.draw do
  resource :newsletter_subscriptions, only: [:create, :index]
  resources :teams, except:  [:show]
  resources :partners, except:  [:show]
  resources :talks, only: [:index]
  resources :speakers, only: [:show]
  resources :events do
    resources :talks, controller: 'event_talks'
  end
  devise_for :users

  root 'events#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
