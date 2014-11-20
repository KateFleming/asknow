class QuestionBank < ActiveRecord::Base
  # Validations
  validate :not_duplicate
  
  belongs_to :feed
  belongs_to :question
  
  # No duplicate entries
  def not_duplicate
    if QuestionBank.find_by(question: question, feed: feed)
      errors.add(:question, "has already been added to this feed")
    end
  end
end
