# frozen_string_literal: true

require 'bunny'
conn = BaseService.new
conn.start

channel = conn.create_channel

# ch.prefetch(2)
q1 = channel.queue('payout_updates', durable: true)

def valid_status?(status)
  %w[accepted rejected].include? status
end

def updater(delivery_info, _channel, payload)
  payment_request_params = JSON.parse(payload, { symbolize_names: true })
  pr = PaymentRequest.find_by(id: payment_request_params[:id])
  status = payment_request_params[:status]
  pr.send(status << '!') if pr.present? && valid_status?(status)
  channel.ack(delivery_info.delivery_tag)
end

q1.subscribe do |delivery_info, _properties, payload|
  updater(delivery_info, channel, payload)
end

