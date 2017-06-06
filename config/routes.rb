Rails.application.routes.draw do

  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  post '/change_categories' =>'professions#change_categories'

  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        passwords: 'users/passwords',
        confirmations: 'users/confirmations',
        unlocks: 'users/unlocks'
      }

  authenticated :user do
    root :to => 'homepage#welcome'
  end

  root 'homepage#index'

  resources :homepage, :only => [:index] do
    collection do
      get :welcome
      get :getstarted
      post :signup_user_and_post_job
    end
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

  
end
