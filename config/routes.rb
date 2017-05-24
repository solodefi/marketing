Rails.application.routes.draw do
  
  resources :homepage, :only => [:index] do
  end

  resources :about, :only => [:index] do 
    collection do
      get :how_it_works
      get :contact_us
    end
  end

  resources :proposals
  resources :categories
  resources :jobs
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        passwords: 'users/passwords',
        confirmations: 'users/confirmations',
        unlocks: 'users/unlocks'
      }

  root 'homepage#index'
end
