module HerokuAuthenticatable
  private
  
    def save_heroku_credentials
      redirect_to env['omniauth.origin'], notice: 'Heroku authenticated successfully.'
    end
end