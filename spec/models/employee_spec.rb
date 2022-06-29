# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'associations' do
    context 'test all association' do
      it 'has many ' do
        relation = described_class.reflect_on_association(:payment_requests)
        expect(relation.macro).to eq :has_many
      end
      it { should have_many(:payment_requests) }
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:email) }
  end
end
