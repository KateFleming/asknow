class Community < ActiveRecord::Base
  has_many :accounts
end
