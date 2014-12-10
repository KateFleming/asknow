class Group < ActiveRecord::Base
  # Validations
  validates :name, presence: true
  
  # Relationships
  has_many :questions
  has_many :group_members
  has_many :accounts, through: :group_members
  
  def default_member_permission
    GroupMemberPermission.find(default_permission)
  end
  
  def visibility
    if private
      "private"
    else
      "public"
    end
  end
end
