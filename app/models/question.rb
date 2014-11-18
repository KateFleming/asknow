class Question < ActiveRecord::Base
  belongs_to :account
  has_many :answers
end
