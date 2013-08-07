module GithubCloneable
  
  module ClassMethods
    def new_from_github_payload(payload)
      data = JSON.parse(payload)
      repo = get_github_repo(data)
      build = new(
        branch: data['ref'].gsub('refs/heads/', ''),
        status: 'waiting'
      )
    
      if data['deleted']
        build.errors.add(:deleted, "can't be true")
      elsif repo
        build.commits = get_github_commits(build, data)
        build.repo = repo
      else
        build.errors.add(:repo, "is not setup")
      end
    
      build
    end
  
    private
  
      def get_github_commits(build, data)
        commits = []
        data['commits'].each do |commit_data|
          commit = Commit.find_by_commit_id(commit_data['id'])
          unless commit
            commit = Commit.new(
              commit_id: commit_data['id'],
              message: commit_data['message'],
              timestamp: Time.parse(commit_data['timestamp']),
              url: commit_data['url']
            )
            commit.committer = get_github_committer(commit_data)
          end
          commits << commit
          if data['head_commit']['id'] == commit.commit_id
            build.head_commit = commit
          end
        end
        commits
      end
  
      def get_github_committer(data)
        committer = Committer.where(username: data['committer']['username'], provider: 'github').first_or_initialize
        committer.name = data['committer']['name']
        committer.email = data['committer']['email']
        committer
      end
  
      def get_github_repo(data)
        Repo.where(provider: 'github', provider_id: data['repository']['id'].to_s).first
      end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
end