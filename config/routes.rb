Rails.application.routes.draw do

  root to: 'transactions#index' # required by Devise

  namespace :api, defaults: { format: :json } do
    resources :users,         only: [:index, :create]
    resources :transactions,  only: [:index, :show, :create]
  end

  namespace :twilio do
    resources :sms, only: :create
  end

  devise_for :users, :controllers => {
    sessions:       'user/sessions',
    registrations:  'user/registrations',
    passwords:      'user/passwords'
  }

end
