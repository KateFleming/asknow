class Question < ActiveRecord::Base
  # Validations
  validates :entry, presence: true, length: { maximum: 100 }
  
  # Relationships
  belongs_to :community
  belongs_to :account
  belongs_to :feed
  has_many :answers
  has_many :question_banks
  
  # Takes data and converts to an array
  def tags
    if keywords
      keywords.split(",")
    else
      []
    end
  end
end
