# frozen_string_literal: true

# Acting as connector
class Employee < ApplicationRecord
  has_many :payment_requests, dependent: :nullify

  validates :first_name, presence: true
  validates :email, presence: true
end
