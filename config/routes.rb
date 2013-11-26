Myapp::Application.routes.draw do
  get "rest_client", to: 'rest_client#new'
  post "rest_client", to: 'rest_client#create'
  resources :reminders

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users do 
    resources :reminders
  end
end
