class Build < ActiveRecord::Base
  include GithubCloneable
  include HerokuDeployable
  include TestRunnable
  
  belongs_to :repo, autosave: true
  belongs_to :head_commit, class_name: 'Commit', autosave: true
  has_and_belongs_to_many :commits, autosave: true
  
  after_create :run_tests
end
