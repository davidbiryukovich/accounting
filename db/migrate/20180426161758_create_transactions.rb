class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.date :date, null: false
      t.decimal  :amount, precision: 10, scale: 2, null: false
      t.integer :category_id, null: false
      t.string :comment, length: 140
    end

    add_index :transactions, :date
    add_index :transactions, :category_id
    add_index :transactions, :comment
  end
end
