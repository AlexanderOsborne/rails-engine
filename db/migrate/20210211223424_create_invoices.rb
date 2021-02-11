class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.references :customers
      t.references :merchants
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
