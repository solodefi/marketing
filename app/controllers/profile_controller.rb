class ProfileController < EndUserBaseController
  def index
    @user = User.find_by(id: params[:user_id])
    if @user.nil?
      @user = current_user
    end
  end
end
