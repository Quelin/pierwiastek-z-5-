class Activity < ActiveRecord::Base
	belongs_to :task

	def duration
		((end_time? ? end_time.to_time : Time.now)- start_time.to_time).to_i
	end
end
