# Include hook code here
require 'acts_as_likeable'
ActiveRecord::Base.send(:include, ActiveRecord::Acts::Likeable)