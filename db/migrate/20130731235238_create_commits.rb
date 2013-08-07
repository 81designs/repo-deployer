class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :commit_id
      t.integer :committer_id
      t.string :message
      t.datetime :timestamp
      t.string :url

      t.timestamps
    end
  end
end
