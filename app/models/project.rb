class Project < ActiveRecord::Base
	has_and_belongs_to_many :users
	belongs_to :client
	has_many :tasks
	has_many :posts
end
