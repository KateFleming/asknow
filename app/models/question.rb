class Question < ActiveRecord::Base
  # Validations
  validates :entry, presence: true, length: { maximum: 125 }
  
  # Relationships
  belongs_to :account
  belongs_to :feed
  belongs_to :group
  
  has_many :answers, dependent: :destroy
  has_many :question_banks, dependent: :destroy
  has_and_belongs_to_many :tags
  
  # Rates a current question based on votes and answers
  def rate
    votes = answers.inject(0) do |sum, a| 
      sum + a.votes.count 
    end
    
    # Return a count of votes and answers
    answers.count + votes
  end
end
