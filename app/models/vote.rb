class Vote < ActiveRecord::Base
  # Validations
  validate :not_duplicate
  
  # Relatioships
  belongs_to :answer
  belongs_to :account
  
  def not_duplicate
    if Vote.where(answer_id: answer_id, account_id: account_id).count > 0
      errors.add(:account_id, "can't vote more than once")
    end
  end
end
