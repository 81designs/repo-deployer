class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.integer :user_id
      t.string :provider
      t.string :provider_id
      t.string :provider_token
      t.string :owner
      t.string :name
      t.string :clone_url
      t.string :url
      t.text :test_commands, default: "bundle exec rake\n# bundle exec rspec\n# bundle exec cucumber\n# bundle exec guard-jasmine"
      t.text :test_setup_commands, default: "bundle install\nexport RAILS_ENV=test\nbundle exec rake db:setup\n# bundle exec rake db:migrate"

      t.timestamps
    end
  end
end
