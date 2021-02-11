class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :invoices
      t.integer :credit_card_number
      t.string :credit_card_expiration_date
      t.integer :results, default: 0, null: false

      t.timestamps
    end
  end
end
