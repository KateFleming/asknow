class Group < ActiveRecord::Base
  # Relationships
  has_many :group_members
  has_many :accounts, through: :group_members
end
