require 'rails_helper'

RSpec.feature 'Listing expenses' do
  before do
    Expense.create!(category: 'Yesterday', made_on: Date.today - 1)
    Expense.create!(category: '2 days ago', made_on: Date.today - 2)
    Expense.create!(category: 'Today', made_on: Date.today)
  end

  scenario 'cannot navigate to the future' do
    visit root_path
    expect(page).not_to have_link('Next')
    expect(page).not_to have_link('Today')
  end

  scenario 'navigate to yesterday' do
    visit root_path
    click_link 'Yesterday'

    expect(page).to have_css('.expense_category', text: 'Yesterday')

    expect(page).not_to have_link('Next day')
    expect(page).not_to have_link('Yesterday')

    expect(page).to have_link('Previous day')
    expect(page).to have_link('Today')
  end

  scenario 'navigate to two days ago' do
    visit by_date_expenses_path(Date.today - 1)
    click_link 'Previous day'

    expect(page).to have_css('.expense_category', text: '2 days ago')
    expect(page).not_to have_link('Yesterday')
    expect(page).to have_link('Previous day')
  end

  scenario 'navigate forward from the past' do
    visit by_date_expenses_path(Date.today - 2)
    click_link 'Next day'

    expect(page).to have_css('.expense_category', text: 'Yesterday')
  end

  scenario 'navigate to today from the past' do
    visit by_date_expenses_path(Date.today - 2)
    click_link 'Today'
    expect(page).to have_css('.expense_category', text: 'Today')
  end
end
