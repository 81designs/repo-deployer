class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.integer :repo_id
      t.integer :head_commit_id
      t.string :branch
      t.string :status

      t.timestamps
    end
  end
end
