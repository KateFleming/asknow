class Answer < ActiveRecord::Base
  # Validations
  validates :entry, presence: true, length: { maximum:50 }
  
  # Relationships
  belongs_to :account
  belongs_to :question
  has_many :votes
end
