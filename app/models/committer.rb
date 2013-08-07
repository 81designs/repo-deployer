class Committer < ActiveRecord::Base
  has_many :commits
  
  def url
    if provider == 'github'
      "https://github.com/#{username}"
    end
  end
end
