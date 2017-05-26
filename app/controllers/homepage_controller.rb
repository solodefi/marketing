class HomepageController < ApplicationController

  before_filter :authenticate_user!, only: [:welcome]

  include RedirectLanding
  
  def index
  
  end

  def welcome
    redirect_to path_to_redirect
  end

end
