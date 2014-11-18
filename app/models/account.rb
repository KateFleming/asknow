class Account < ActiveRecord::Base
  # Use secure password, but only require when creating a member
  has_secure_password validations: false
  validates :type, presence: true
  
  # Relationships
  belongs_to :community
  has_many :questions
  
  def member?
    type == 'Member'
  end
  def guest?
    type == 'Guest'
  end
end
