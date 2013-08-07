class CreateCommitters < ActiveRecord::Migration
  def change
    create_table :committers do |t|
      t.string :name
      t.string :email
      t.string :provider
      t.string :username

      t.timestamps
    end
  end
end
