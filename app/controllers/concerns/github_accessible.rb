module GithubAccessible
  
  def add_github_repo
    github_repo = github_client.repos.get(params[:owner], params[:repo])
    
    @repo = Repo.find_by_user_id_and_provider_and_provider_id(current_user.id, 'github', github_repo.id.to_s)
    
    if @repo
      redirect_to repo_builds_path(@repo), alert: 'GitHub repo was previously added already.'
    else
      @repo = Repo.new(
        name: github_repo.name,
        owner: github_repo.owner.login, 
        provider: 'github', 
        provider_id: github_repo.id.to_s, 
        url: github_repo.html_url,
        clone_url: github_repo.clone_url.gsub("https://", "https://#{current_user.token}:x-oauth-basic@")
      )
      @repo.user_id = current_user.id
      @repo.provider_token = current_user.token
    
      if @repo.save
        add_github_webhook
        redirect_to repo_builds_path(@repo), notice: 'GitHub repo added successfully.'
      else
        render :action, alert: 'GitHub repo could not be added.'
      end
    end
  end
  
  def github
    @provider = 'github'
    @github_repos = [{ 
      owner: github_client.users.get.login, 
      repos: github_client.repos.all.sort_by{|repo| repo.full_name.downcase }
    }]
    @github_repos += github_client.orgs.all.map do |org|
      { 
        owner: org.login, 
        repos: github_client.repos.all(org: org.login).sort_by{|repo| repo.full_name.downcase }
      }
    end
  end
  
  def github_hook
    @build = Build.new_from_github_payload(params[:payload])

    if @build.save
      render json: @build
    else
      render json: @build.errors, status: :unprocessable_entity
    end
  end
  
  private
  
    def add_github_webhook
      begin
        github_client.repos.hooks.create @repo.owner, @repo.name, 
          name: 'web',
          active: true, 
          config: {
            url: github_hook_repos_url
          }
      rescue
        logger.debug "Hook `#{github_hook_repos_url}` was already added?"
      end
    end

    def github_client
      @github_client ||= Github.new(oauth_token: current_user.token)
    end
  
end