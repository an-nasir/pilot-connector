# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PaymentRequests', type: :request do
  describe 'GET /index' do
    before { get :index }
    it 'renders the index template' do
      it { expect(response).to have_http_status(:success) }
      it { should render_template('index') }
    end
  end
end
