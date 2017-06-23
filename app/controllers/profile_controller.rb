class ProfileController < EndUserBaseController
  def index
    @user = current_user
  end
end
