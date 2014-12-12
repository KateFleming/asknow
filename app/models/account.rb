require 'digest'
require 'digest/sha2'
class Account < ActiveRecord::Base
  # Use secure password, but only require when creating a member
  has_secure_password validations: false
  validate :type_specific_validation
  
  # Relationships
  has_many :feeds
  has_many :questions
  has_many :answers
  has_many :votes
  has_many :group_members, dependent: :destroy
  has_many :groups, through: :group_members
  has_one :account_settings
  
  ROLES = %w[admin member guest banned]
  
  def type
    case account_type
    when 'banned'
      Guest.new
      # Banned can't do anything
    when 'guest'
      Guest.new
    when 'member'
      Member.new
    when 'admin'
      Admin.new
    else
      raise "Unknown account type"
    end
  end
  
  def banned?
    account_type == 'banned'
  end
  def member?
    account_type == 'member'
  end
  def guest?
    account_type == 'guest'
  end
  def admin?
    account_type == 'admin'
  end
  
  def display_name
    if self.guest?
      "Guest"
    else
      self.name
    end
  end
  
  # Does the account own an item
  def owns?(item)
    item.account == self
  end
  
  def group_member?(group)
    self.groups.where(id: group.id).count > 0
  end
  
  # Find if a user has voted
  def voted_on?(answer)
    has_voted = false
    answer.votes.each do |vote|
      if vote.account == self
        has_voted = true 
      end
    end
    has_voted
  end
  
  def primary_feed
    Feed.find_by(account: self, primary: true)
  end
  
  def generate_code
    salt = (0...8).map { (65 + rand(26)).chr }.join
    self.code = ::Digest::SHA2.new.hexdigest(email + salt)
  end
  
  def settings
    # Create account settings if they don't exist
    unless account_settings
      AccountSettings.create(account: self)
    end
    account_settings
  end
  
  private
  # Validations
  def type_specific_validation
    type.validate_account(self)
  end
end
