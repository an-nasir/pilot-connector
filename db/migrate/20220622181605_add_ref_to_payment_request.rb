# frozen_string_literal: true

#
# migration for ref
class AddRefToPaymentRequest < ActiveRecord::Migration[6.1]
  def change
    add_reference :payment_requests, :employee, foreign_key: true
  end
end
