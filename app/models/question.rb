class Question < ActiveRecord::Base
  # Validations
  validates :entry, presence: true, length: { maximum: 100 }
  
  # Relationships
  belongs_to :community
  belongs_to :account
  belongs_to :feed
  has_many :answers, dependent: :destroy
  has_many :question_banks, dependent: :destroy
  
  # Takes data and converts to an array
  def tags
    if keywords
      keywords.split(",")
    else
      []
    end
  end
  
  # Rates a current question based on votes and answers
  def rate
    votes = answers.inject(0) do |sum, a| 
      sum + a.votes.count 
    end
    
    # Return a count of votes and answers
    answers.count + votes
  end
  
  # Finds by community
  def self.community(place)
    self.where(community: place).order('id')
  end
end
