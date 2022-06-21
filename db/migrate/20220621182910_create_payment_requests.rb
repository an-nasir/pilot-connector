class CreatePaymentRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_requests do |t|
      t.decimal :amount, precision: 8, scale: 2
      t.string :currency
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
