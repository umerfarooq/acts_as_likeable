class Liking < ActiveRecord::Base
  belongs_to :likeable, :polymorphic => true
  
  # NOTE: Likings belong to a user
  belongs_to :user

  named_scope :likes, :conditions => {:liking => 1}
  named_scope :dislikes, :conditions => {:liking => 0}
  
  # Helper class method to lookup all likings assigned to all likeable types for a given user.
  def self.find_all_likings_by_user(user)
    find(
      :all,
      :conditions => ["user_id = ?", user.id],
      :order => "created_at DESC"
    )
  end
end