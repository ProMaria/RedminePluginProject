class RedmineWarehouseProduct < ActiveRecord::Base
	belongs_to :issue
	validates_uniqueness_of :name
end
