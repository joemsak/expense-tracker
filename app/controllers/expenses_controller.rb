class ExpensesController < ApplicationController
  def new
    @expense = Expense.new
  end

  def create
    expense = Expense.create!(expense_params)
    flash[:notice] = "Your expense has been recorded"
    redirect_to dated_path_for(expense)
  end

  def by_date
    @expenses = Expense.by_date(params[:date])
    render template: 'expenses/index'
  end

  def today
    @expenses = Expense.today
    render template: 'expenses/index'
  end

  private
  def expense_params
    params.require(:expense).permit(:category, :amount, :made_on)
  end

  def dated_path_for(expense)
    case expense.made_on
    when Date.today
      today_expenses_path
    else
      by_date_expenses_path(expense.made_on)
    end
  end
end
