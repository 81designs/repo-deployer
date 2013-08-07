module TestRunnable
  def run_tests
    clone_repo
  end
  handle_asynchronously :run_tests
  
  private

    def clone_repo
      self.status = 'cloning'
      self.save
      Dir.mkdir('builds') unless File.exists?('builds')
      Dir.mkdir('builds/logs') unless File.exists?('builds/logs')
      File.open("builds/logs/#{self.id}.log", "w") do |f|
        f.write "Cloning repo..."
      end
      if system("git clone --depth 50 #{self.repo.clone_url} builds/#{self.id}")
        if system("cd builds/#{self.id}; git fetch origin #{self.head_commit.commit_id}; git checkout #{self.head_commit.commit_id}")
          run_setup_commands
        end
      end
    end
    
    def run_setup_commands
      self.status = 'starting'
      self.save
      if system("#{self.repo.test_setup_commands}")
        run_test_commands
      end
    end
    
    def run_test_commands
      self.status = 'running'
      self.save
      if system("#{self.repo.test_commands}")
        self.status = 'passed'
        self.save
      else
        self.status = 'failed'
        self.save
      end
    end
end