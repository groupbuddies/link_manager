class SessionsController < ApplicationController
  skip_before_action :require_login, except: :destroy

  def new
    if current_user.signed_in?
      redirect_to links_path
      return
    else
      render :new, layout: 'simple'
    end
  end

  def create_from_omniauth
    headquarters_user(auth_hash.info.email)
    redirect_to links_path
  end

  def destroy
    User::Store.delete cookies[:auth_token]
    cookies[:auth_token] = nil
    redirect_to root_path
  end

  private

  def headquarters_user(email)
    user_data = Headquarters::Client::Members.new(
      client_id: ENV['HQ_APP_ID'],
      client_secret: ENV['HQ_APP_SECRET']
    ).search(email).first
    return unless user_data

    cookies[:auth_token] = params[:code]
    user = User.new user_data, params[:code]
    User::Store.add user
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
