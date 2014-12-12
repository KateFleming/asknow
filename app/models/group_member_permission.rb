class GroupMemberPermission < ActiveRecord::Base
  has_many :group_members
  # Returns the ID of the powerizer permission
  def self.powerizer
    self.find(1)
  end
end
