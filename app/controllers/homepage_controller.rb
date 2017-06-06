class HomepageController < ApplicationController

  before_filter :authenticate_user!, only: [:welcome]

  include RedirectLanding
  
  def index
  
  end

  def welcome
    redirect_to path_to_redirect
  end

  def getstarted
    @user = User.new
    @job = Job.new
  end

  def signup_user_and_post_job
    @user = User.new(user_params)
    @user.user_type = "Client"
    @user.save

    @job = Job.new(job_params)
    @job.user_id = @user.id
    @job.save

    sign_in @user

    redirect_to jobs_url
  end

  def job_params
    params.require(:job).permit(:title, :price, :description, :postcode, :start_date, :end_date, :user_id, :profession_id, :category_ids => [])
  end

  def user_params
    params.require(:user).permit({ roles: [] }, :title, :first_name, :last_name, :country, :email, :password, :password_confirmation, :image, :user_type, :postcode)
  end

end
