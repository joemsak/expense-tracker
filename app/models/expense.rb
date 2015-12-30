class Expense < ActiveRecord::Base
  scope :today, -> { where(made_on: Date.today) }
  scope :by_date, ->(date) { where(made_on: date) }
end
