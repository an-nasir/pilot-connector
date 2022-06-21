# frozen_string_literal: true

# consists of all payment requests from contractor
class PaymentRequest < ApplicationRecord
  enum status: { pending: 0, accepted: 1, rejected: 2 }
  def validate
    errors.add(:amount, 'should be at least 0.01') if amount.nil? || amount < 0.01
  end

  after_commit :notify_manager

  private

  def notify_manager
    # TODO: Write Publish code here
  end
end
