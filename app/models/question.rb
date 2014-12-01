class Question < ActiveRecord::Base
  # Validations
  validates :entry, presence: true, length: { maximum: 100 }
  
  # Relationships
  belongs_to :account
  belongs_to :feed
  has_many :answers, dependent: :destroy
  has_many :question_banks, dependent: :destroy
  
  # Takes data and converts to an array
  def keywords
    if tags
      tags.split(",").collect do |tag|
        if Tag.exists?(tag)
          Tag.find(tag)
        end
      end
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
end
