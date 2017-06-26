module UsersHelper

  def show_avatar(user, style_class)
    if user.image?
      image_tag(user.image.custom_crop, class: style_class)
    else
      render partial: 'shared/avatar', locals: {user: user, style_class: style_class}
    end
  end

end