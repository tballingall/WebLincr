#
module ProfileHelper
  def avatar(user)
    return image_tag user.avatar.thumb('400x200#').url if user.avatar_stored?
    image_tag 'http://placehold.it/200x200'
  end

  def edit_profile_link(user)
    return edit_profile_link! if current_user?(user)
    ''
  end

  def new_album_link(user)
    return new_album_link! if current_user?(user)
    ''
  end

  private

  def edit_profile_link!
    link_to t('user.profile.edit_link'), edit_user_path(@user)
  end

  def new_album_link!
    link_to t('album.new.link'), new_user_album_path(@user)
  end
end
