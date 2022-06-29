# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BaseService, type: :model do
  describe '#initializer' do
    let(:base) { BaseService.new }
    # it 'returns bunny channel' do
    #   expect(base.connection).to_not eq(nil)
    # end
    it { should delegate_method(:start).to(base.connection) }
    it { should delegate_method(:stop).to(base.connection) }
  end
end
