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

  devise_scope :user do 
    get '/fill_profile', :action => 'fill_profile', :controller => 'users/registrations'
    post '/update_profile_after_sign_up', :action => 'update_profile_after_sign_up', :controller => 'users/registrations'

    get '/settings', :action => 'settings', :controller => 'users/registrations'
    patch '/update_settings', :action => 'update_settings', :controller => 'users/registrations'
  end

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
      post :send_contact_us_message
    end
  end

  resources :profile, :only => [:index] do
  end

  resources :proposals, :except => [:edit, :destroy]
  resources :categories

  resources :jobs do
    collection do
      get :browse
      get :browse_job_details
      get :in_progress
      post :hire_freelancer
    end
  end

  resources :conversations do
    resources :messages
  end
  
end
