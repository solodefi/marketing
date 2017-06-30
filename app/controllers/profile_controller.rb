class ProfileController < EndUserBaseController

  before_action :authenticate_user!, except: [:index, :freelancer_search]

  def index
    @user = User.find_by(id: params[:user_id])
    if @user.nil?
      @user = current_user
    end
  end

  def freelancer_search
    @searchText = params[:searchText]
    @searchText = @searchText.downcase()
    
    @allfreelancers = User.where(:user_type => 'Freelancer')
    @users = Array.new
    @allfreelancers.each do |fr|
      
      if fr.name.downcase().include? @searchText
        @users.append(fr)
      elsif fr.title.downcase().include? @searchText
        @users.append(fr)
      elsif fr.postcode.downcase().include? @searchText
        @users.append(fr)
      elsif fr.profession.to_s.downcase().include? @searchText
        @users.append(fr)
      elsif fr.overview.downcase().include? @searchText
        @users.append(fr)
      end
    end
  end

end
