class Vote < ActiveRecord::Base
  belongs_to :answer
  belongs_to :account
end
