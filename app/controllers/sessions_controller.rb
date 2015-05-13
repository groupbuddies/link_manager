class SessionsController < ApplicationController
  def create_from_omniauth
    headquarters_user(auth_hash.info.email)
    redirect_to root_path
  end

  def destroy
    session[:current_user] = nil
    redirect_to root_path
  end

  private

  def headquarters_user(email)
    user_data = Headquarters::Client::Members.new(
      client_id: ENV['HQ_APP_ID'],
      client_secret: ENV['HQ_APP_SECRET']
    ).search(email).first
    return unless user_data

    session[:current_user] = {}
    session[:current_user][:name] = user_data['name']
    session[:current_user][:email] = user_data['email']
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
