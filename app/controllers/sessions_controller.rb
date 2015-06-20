# Controller for all session actions
#
class SessionsController < ApplicationController
  def new
    @user = user
  end

  def create
    if authed?(user)
      login(user)
    else
      sleep(rand * 0.25)
      flash[:notice] = I18n.t('user.errors.login')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: I18n.t('user.logout.success')
  end

  private

  def authed?(user)
    user.authenticate(params[:password])
  end

  def login(user)
    session[:user_id] = user.id
    redirect_to root_path, notice: I18n.t('user.login.success')
  end

  def user
    @user ||= User.find_by_email(params[:email])
  end
end
