require 'rails_helper'

RSpec.feature 'Recording expenses' do
  scenario "defaults to today's date" do
    visit new_expense_path

    fill_in 'Category', with: 'Food & Beverage'
    fill_in 'Amount', with: 15
    click_button 'Save expense'

    expect(current_path).to eq(today_expenses_path)
    expect(page).to have_css('.flash.notice', text: 'Your expense has been recorded')

    within('.expenses .expense') do
      expect(page).to have_css('.expense_category', text: 'Food & Beverage')
      expect(page).to have_css('.expense_amount', text: '$15.00')
    end
  end
end
