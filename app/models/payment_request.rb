# frozen_string_literal: true

# consists of all payment requests of contractor
class PaymentRequest < ApplicationRecord
  enum status: { pending: 0, accepted: 1, rejected: 2 }, _default: :pending

  belongs_to :employee
  validates :currency, presence: true

  def validate
    errors.add(:amount, 'should be at least 0.01') if amount.nil? || amount < 0.01
  end

  after_commit :notify_manager

  private

  def notify_manager
    # TODO: Write Publish code here
    Publisher.publish('payment_requests', attributes)
  end
end
