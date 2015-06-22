# Controller for all user actions
#
class UsersController < ApplicationController
  include ProfileHelper
  before_action :require_login, only: [:edit, :update]
  before_action :ensure_current_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: I18n.t('user.sign_up.success')
    else
      render 'new'
    end
  end

  def edit
    user
  end

  def update
    if user.update_attributes(user_params)
      redirect_to user_path(user), notice: I18n.t('user.profile.success')
    else
      render 'edit'
    end
  end

  private

  def user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user)
      .permit(:email, :password, :password_confirmation, :avatar)
  end
end
