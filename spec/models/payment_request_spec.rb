# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe PaymentRequest, type: :model do
  let(:employee) { Employee.create!(id: 1, first_name: 'Nasir', email: 'nasir@example.com') }

  let(:not_valid_pr) { described_class.new(amount: 0.0, employee_id: nil, currency: '', status: nil) }
  let(:valid_pr) { described_class.new(amount: 2, employee_id: employee.id, currency: 'USD') }
  subject { described_class.new(amount: 10, currency: 'USD', description: 'Nope', employee_id: employee.id) }

  describe 'associations' do
    context 'test all association' do
      it 'belongs to' do
        relation = described_class.reflect_on_association(:employee)
        expect(relation.macro).to eq :belongs_to
      end
      it { should belong_to(:employee) }
    end
  end
  describe '#validations' do
    context 'checks validations' do
      it 'is valid with valid values' do
        expect(not_valid_pr).to_not be_valid
      end

      it 'is not valid with valid with 0.0 amount' do
        expect(not_valid_pr).to_not be_valid
      end

      it 'is valid with all validation' do
        expect(valid_pr).to be_valid
      end

      it 'is not valid without currency' do
        subject.currency = nil
        expect(subject).to_not be_valid
      end

      it 'cannot create a payment request if its amount 0.0' do
        pr = PaymentRequest.create(amount: 0.0, currency: 'USD', description: 'Nope', employee_id: employee.id)
        expect(pr.errors[:amount].last).to eq 'should be at least 0.01'
      end
    end
  end

  describe 'enum' do
    context 'check enum valid' do
      it { should define_enum_for(:status).with_values(%i[pending accepted rejected]) }
    end
  end
end
# rubocop:enable Metrics/BlockLength
