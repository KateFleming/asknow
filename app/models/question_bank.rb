class QuestionBank < ActiveRecord::Base
  belongs_to :feed
  belongs_to :question
end
