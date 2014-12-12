class Group < ActiveRecord::Base
  # Validations
  validates :name, presence: true
  
  # Relationships
  has_many :questions
  has_many :group_members
  has_many :accounts, through: :group_members
  
  before_save :generate_invite_code
  
  def default_member_permission
    GroupMemberPermission.find(default_permission)
  end
  
  # Creates a random invite code, this isn't the most secure
  # way to do this, but it's a lot easier to share.
  def generate_invite_code
    loop do
      self.invite_code = (0...8).map { (65 + rand(26)).chr }.join
      break unless Group.find_by(invite_code: invite_code)
    end
  end
  
  # Get that user's permissions
  def account_permission(account)
    group_members.joins(:account).where(account: account).first.group_member_permission
  end
end
