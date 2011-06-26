# ActsAsLikeable
module ActiveRecord
  module Acts
    module Likeable

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def acts_as_likeable
          has_many :likings, :as => :likeable, :dependent => :destroy
          include ActiveRecord::Acts::Likeable::InstanceMethods
        end
      end

      # This module contains instance methods
      module InstanceMethods
        # Helper method that associates the Liking with the Object
        def add_liking(liking)
          likings << liking
        end

        # Helper method to calculate the total likes for this Likeable
        def likes_count
          likes = Liking.find(
            :all,
            :conditions => ["likeable_id = ? AND likeable_type = ? AND liking = TRUE",id, self.type.name])
          likes.size
        end

        # Helper method to calculate the total dislikes for this Likeable
        def dislikes_count
          likes = Liking.find(
            :all,
            :conditions => ["likeable_id = ? AND likeable_type = ? AND liking = FALSE",id, self.type.name])
          likes.size
        end

        # Helper method to calculate the total likings for this Likeable
        def likings_count
          self.likings.size
        end

        # Helper method to calculate the percentage of likes to dislikes for this Likeable
        def likes_percentage
          (likes_count*100)/likings_count
        end

        # Helper method to calculate the percentage of dislikes to likes for this Likeable
        def dislikes_percentage
          (dislikes_count*100)/likings_count
        end

        # Helper method to see if a user already liked this likeable
        def liked_by_user?(user)
          rtn = false
          if user
            self.likings.each { |l|
              rtn = true if user.id == l.user_id
            }
          end
          rtn
        end
      end
    end
  end
end
