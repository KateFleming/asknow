class Feed < ActiveRecord::Base
  # Validations
  validates :tag, uniqueness: true
  
  # Relationships
  belongs_to :account
  has_many :question_banks
end
