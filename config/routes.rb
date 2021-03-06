Rails.application.routes.draw do
  resources :newsletter_subscriptions, only: [:create, :index]
  resources :teams, except:  [:show]
  resources :partners, except:  [:show]
  resources :talks, only: [:index]
  resources :speakers, only: [:show]
  resources :events do
    resources :talks, controller: 'event_talks'
    resources :partners, controller: 'event_partners'
  end
  resources :dynamic_copies do
    collection do
      get :get_by_key
    end
  end
  devise_for :users

  root 'events#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
