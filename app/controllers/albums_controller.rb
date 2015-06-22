# Controller for all user actions
#
class AlbumsController < ApplicationController
  before_action :require_login, except: [:show, :index]
  before_action :ensure_current_user, except: [:show, :index]

  def show
    @album = album
  end

  def new
    @album = current_user.albums.new
  end

  def edit
    @album = album
  end

  def create
    @album = current_user.albums.new(album_params)
    if @album.save
      redirect_to album_path(@album),
                  notice: I18n.t('album.create.success')
    else
      render 'new'
    end
  end

  def update
    if album.update_attributes(album_params)
      redirect_to album_path(album),
                  notice: I18n.t('album.update.success')
    else
      render 'edit'
    end
  end

  private

  def album
    @album ||= Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:name)
  end

  def user
    return album.user unless params[:user_id].present?
    @_album ||= User.find(params[:user_id])
  end
end
