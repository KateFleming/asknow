class Account < ActiveRecord::Base
  # Use secure password, but only require when creating a member
  has_secure_password validations: false
  validates :type, presence: true
  
  # Relationships
  belongs_to :community
  has_many :feeds
  has_many :questions
  has_many :answers
  has_many :votes
  
  def member?
    type == 'Member'
  end
  
  def guest?
    type == 'Guest'
  end
  
  def primary_feed
    Feed.find_by(account: self, primary: true)
  end
end
