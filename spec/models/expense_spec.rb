require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe 'scopes' do
    context '.today' do
      it 'includes expenses made today' do
        today = Expense.create!(made_on: Date.today)
        expect(Expense.today).to include(today)
      end

      it 'does not include expenses made before or somehow after today' do
        yesterday = Expense.create!(made_on: Date.today - 1)
        tomorrow = Expense.create!(made_on: Date.today + 1)
        expect(Expense.today).to be_empty
      end
    end
  end
end
