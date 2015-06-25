# Controller for all user actions
#
class PicturesController < ApplicationController
  before_action :require_login, except: [:show, :index]
  before_action :ensure_current_user, except: [:show, :index]

  def new
    @picture = album.pictures.new
  end

  def create
    @picture = album.pictures.new(picture_params)
    if @picture.save
      redirect_to album_path(album), notice: I18n.t('album.picture.success')
    else
      render :new
    end
  end

  def cover
    album.update_attributes(cover: picture)
    redirect_to album_path(album), notice: I18n.t('album.picture.success')
  end

  private

  def album
    return picture.album unless params[:album_id].present?
    @_album ||= Album.find(params[:album_id])
  end

  def picture
    @_picture ||= Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:name, :description, :year, :color, :image)
  end

  def user
    album.user
  end
end
