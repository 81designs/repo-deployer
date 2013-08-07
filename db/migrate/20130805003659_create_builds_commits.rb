class CreateBuildsCommits < ActiveRecord::Migration
  def change
    create_table :builds_commits do |t|
      t.integer :build_id
      t.integer :commit_id
    end
  end
end
