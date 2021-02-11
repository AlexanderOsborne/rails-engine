class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.references :customers, foreign_key: true
      t.references :merchants, foreign_key: true
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
