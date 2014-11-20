class Community < ActiveRecord::Base
  # Validations
  validates :name, presence: true
  
  # Relationships
  has_many :accounts
  has_many :questions
end
