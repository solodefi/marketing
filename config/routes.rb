Rails.application.routes.draw do

  
  resources :events
  get 'dashboard/index'

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
    get '/confirm_email', :action => 'confirm_email', :controller => 'users/confirmations'
    get '/verification_email', :action => 'verification_email', :controller => 'users/registrations'
    get '/fill_profile', :action => 'fill_profile', :controller => 'users/registrations'
    post '/update_profile_after_sign_up', :action => 'update_profile_after_sign_up', :controller => 'users/registrations'

    get '/settings', :action => 'settings', :controller => 'users/registrations'
    patch '/update_settings', :action => 'update_settings', :controller => 'users/registrations'
    patch '/update_get_paid_email', :action => 'update_get_paid_email', :controller => 'users/registrations'
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

  resources :portfolio, :only => [:index, :new, :create, :edit, :update, :destroy] do
    collection do
    end
  end

  resources :about, :only => [:index] do 
    collection do
      get :how_it_works
      get :contact_us
      get :invite_friends
      get :privacy_policy
      get :terms
      post :send_contact_us_message
      post :send_invite_friends_message
    end
  end

  resources :profile, :only => [:index] do
    get :freelancer_search, on: :collection
  end

  resources :client_reviews, :only => [:new, :create] do
  end

  resources :freelancer_reviews, :only => [:new, :create] do
  end

  resources :transactions, :only => [:new, :create] do
    collection do
      get :client_history
      get :freelancer_history
    end
  end

  resources :deposits, :only => [:new] do
    collection do
      get :on_confirm
      get :on_success
      get :on_failed
      post :perform_purchase
    end
  end

  resources :withdraws, :only => [:new, :create] do 
    collection do
      get :on_failed
    end
  end

  resources :proposals, :except => [:edit, :destroy]
  resources :categories

  resources :jobs do
    collection do
      post :download_file
      get :job_search
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
