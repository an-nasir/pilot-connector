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

# service = ConsumerService.new
# conn = service.mq_connection
# conn.start
# ch = service.create_channel
# service.declare_queue
# service.queue.subscribe(manual_ack: true) do |_delivery_info, _properties, payload|
#   payment_request_params = JSON.parse(payload, { symbolize_names: true })
#   payment_request_params[:emp_payment_request_id] = payment_request_params.delete :id
#   p payment_request_params
#   PaymentRequest.create(payment_request_params)
#   ch.ack(_delivery_info.delivery_tag)
# end
