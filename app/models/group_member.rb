class GroupMember < ActiveRecord::Base
  belongs_to :group
  belongs_to :account
  belongs_to :group_permission
end
