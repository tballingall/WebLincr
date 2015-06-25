#
module AlbumsHelper
  def update_album_link(album)
    return update_album_link!(album) if permitted?(album.user)
    ''
  end

  def add_picture_link(album)
    return add_picture_link!(album) if permitted?(album.user)
    ''
  end

  def create_cover_link(picture)
    return '' unless permitted?(picture.user)
    return '' if picture.album.cover?(picture)
    create_cover_link!(picture)
  end

  private

  def update_album_link!(album)
    link_to I18n.t('album.update.link'), edit_album_path(album)
  end

  def add_picture_link!(album)
    link_to I18n.t('album.picture.add_link'), new_album_picture_path(album)
  end

  def create_cover_link!(picture)
    link_to t('album.picture.make_primary'), cover_picture_path(picture)
  end
end
