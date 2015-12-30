class ExpensesController < ApplicationController
  def new
    @expense = Expense.new
  end

  def create
    Expense.create!(expense_params)
    flash[:notice] = "Your expense has been recorded"
    redirect_to today_expenses_path
  end

  def today
    @expenses = Expense.today
  end

  private
  def expense_params
    params.require(:expense).permit(:category, :amount, :made_on)
  end
end
