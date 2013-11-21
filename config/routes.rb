Myapp::Application.routes.draw do
  resources :reminders

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users do 
    resources :reminders
  end
end
