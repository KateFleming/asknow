class Account < ActiveRecord::Base
  # Use secure password, but only require when creating a member
  has_secure_password validations: false
  validate :type_specific_validation
  
  # Relationships
  belongs_to :community
  has_many :feeds
  has_many :questions
  has_many :answers
  has_many :votes
  
  def type
    case account_type
    when 'member'
      Member.new
    when 'guest'
      Guest.new
    else
      raise "Unknown account type"
    end
  end
  
  def type_specific_validation
    type.validate_account(self)
  end
  
  def member?
    account_type == 'member'
  end
  
  def guest?
    account_type == 'guest'
  end
  
  # Does the account own an item
  def owns?(item)
    item.account == self
  end
  def primary_feed
    Feed.find_by(account: self, primary: true)
  end
end
