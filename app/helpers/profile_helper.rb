#
module ProfileHelper
  def edit_profile_link(user)
    return edit_profile_link! if current_user?(user)
    ''
  end

  def avatar(user)
    return image_tag user.avatar.thumb('400x200#').url if user.avatar_stored?
  end

  private

  def edit_profile_link!
    link_to t('user.profile.edit_link'), edit_user_path(@user)
  end
end
