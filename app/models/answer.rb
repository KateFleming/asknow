class Answer < ActiveRecord::Base
  # Validations
  validates :entry, presence: true, length: { maximum:50 }
  after_save :rate_question
  
  # Relationships
  belongs_to :account
  belongs_to :question
  has_many :votes
  
  def rate_question
    question.rating = question.rate
    if !question.save
      logger.error(question)
    end
  end
end
