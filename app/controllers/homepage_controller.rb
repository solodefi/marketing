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
    @job = Job.new(job_params)
    respond_to do |format|
      @user.user_type = "Client"

      if @user.save
        @job.user_id = @user.id

        if @job.save
          sign_in @user
          format.html { redirect_to jobs_url, notice: "You have signed up & posted a job successfully!" }
        else
          format.html { render :getstarted }
        end
      else
        format.html { render :getstarted }
      end
    end

  end

  def job_params
    params.require(:job).permit(:title, :price, :description, :postcode, :start_date, :end_date, :user_id, :profession_id, :category_ids => [], :attachments => [])
  end

  def user_params
    params.require(:user).permit({ roles: [] }, :title, :first_name, :last_name, :country, :email, :password, :password_confirmation, :image, :user_type, :postcode)
  end

end
