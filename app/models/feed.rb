class Feed < ActiveRecord::Base
  # Validations
  validates :tag, uniqueness: true, allow_nil: true
  validate :one_primary_per_account
  
  # Relationships
  belongs_to :account
  has_many :question_banks
  
  # Each account can only have one primary feed
  def one_primary_per_account
    if Feed.find_by(account: account, primary: true)
      errors.add(:tag, "can't have more than one primary feed")
    end
  end
end
