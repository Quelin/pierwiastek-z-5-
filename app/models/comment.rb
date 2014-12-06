class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post, counter_cache: :count
end
