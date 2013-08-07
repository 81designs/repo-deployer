class SessionsController < ApplicationController
  include GithubAuthenticatable
  include HerokuAuthenticatable
  
  def create
    case env['omniauth.auth']['provider']
    when 'github'
      create_github_session
    when 'heroku'
      if current_user
        save_heroku_credentials
      else
        redirect_to root_url, :alert => 'You must be signed in to add Heroku credentials.'
      end
    else
      redirect_to root_url, :alert => 'OAuth method failed.'
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => 'Signed out successfully.'
  end
end
