class Commit < ActiveRecord::Base
  belongs_to :committer, autosave: true
  has_and_belongs_to_many :builds
end
