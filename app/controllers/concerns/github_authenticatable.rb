module GithubAuthenticatable
  private
  
    def create_github_session
      user = User.where(provider: env['omniauth.auth']['provider'], uid: env['omniauth.auth']['uid']).first_or_initialize
      if user.new_record?
        user.name = env['omniauth.auth']['info']['name']
        user.token = env['omniauth.auth']['credentials']['token']
        user.save
      end
      @current_user = user
      session[:user_id] = user.id
      redirect_to root_url, :notice => 'Signed in with GitHub.'
    end
end