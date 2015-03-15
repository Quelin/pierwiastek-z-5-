class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :activities

  scope :undone, -> { where(done: false) }
  scope :done_tasks, -> { where(done: true) }


	def logged
		activities.map(&:duration).sum
	end

	 def work?
    !activities.empty? && !activities.last.end_time
  end



end
