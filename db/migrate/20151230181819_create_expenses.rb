class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :category
      t.float :amount
      t.date :made_on

      t.timestamps null: false
    end
  end
end
