class RedmineWarehouseProduct < ActiveRecord::Base
	belongs_to :issue
	validates_presence_of :name, :message => ' товара не может быть пустым'
  validates_uniqueness_of :name, :message => 'товара не может повторяться'
  
	def self.safe_attributes(*args)
        @safe_attributes ||= []
        if args.empty?
          if superclass.include?(Redmine::SafeAttributes)
            @safe_attributes + superclass.safe_attributes 
          else
            @safe_attributes
          end
        else
          options = args.last.is_a?(Hash) ? args.pop : {}
          @safe_attributes << [args, options]
        end
      end
  end
