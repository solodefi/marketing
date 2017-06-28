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

  resources :client_reviews, :only => [:new, :create] do
  end

  resources :freelancer_reviews, :only => [:new, :create] do
  end

  resources :proposals, :except => [:edit, :destroy]
  resources :categories

  resources :jobs do
    collection do
      get :browse
      get :browse_job_details
      get :in_progress
      get :in_progress_details
      get :ended
      get :ended_details
      post :hire_freelancer
      post :end_contract
      get :in_progress_by_freelancer
      get :in_progress_by_freelancer_details
      get :ended_for_freelancer
      get :ended_for_freelancer_details
    end
  end

  resources :conversations do
    resources :messages
  end
  
end
