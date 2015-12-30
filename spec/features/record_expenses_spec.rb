require 'rails_helper'

RSpec.feature 'Recording expenses' do
  before do
    visit root_path
    click_link 'Add expense'

    fill_in 'Category', with: 'Food & Beverage'
    fill_in 'Amount', with: 15
  end

  scenario "defaults to today's date" do
    click_button 'Save expense'

    expect(current_path).to eq(today_expenses_path)
    expect(page).to have_css('.flash.notice', text: 'Your expense has been recorded')

    within('.expenses .expense') do
      expect(page).to have_css('.expense_category', text: 'Food & Beverage')
      expect(page).to have_css('.expense_amount', text: '$15.00')
    end
  end

  scenario 'for a past date' do
    fill_in 'Made on', with: Date.today - 1
    click_button 'Save expense'

    expect(current_path).to eq(by_date_expenses_path(Date.today - 1))
    expect(page).to have_css('.flash.notice', text: 'Your expense has been recorded')

    within('.expenses .expense') do
      expect(page).to have_css('.expense_category', text: 'Food & Beverage')
      expect(page).to have_css('.expense_amount', text: '$15.00')
    end
  end
end
