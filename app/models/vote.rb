class Vote < ActiveRecord::Base
  # Validations
  validate :not_duplicate
  after_save :rate_question
  
  # Relatioships
  belongs_to :answer
  belongs_to :account
  
  def not_duplicate
    if Vote.where(answer_id: answer_id, account_id: account_id).count > 0
      errors.add(:account_id, "can't vote more than once")
    end
  end
  
  def rate_question
    question = answer.question 
    question.rating = question.rate
    if !question.save
      logger.error(question)
    end
  end
end
