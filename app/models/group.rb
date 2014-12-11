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
  
  def generate_invite_code
    loop do
      self.invite_code = (0...8).map { (65 + rand(26)).chr }.join
      break unless Group.find_by(invite_code: invite_code)
    end
  end
end
