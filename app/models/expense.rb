class Expense < ActiveRecord::Base
  scope :today, -> { where(made_on: Date.today) }
end
