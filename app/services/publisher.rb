# frozen_string_literal: true

# /app/services/publisher.rb
#
class Publisher
  def self.publish(payload = {})
    producer = Producer.new
    queue = producer.declare_queue('payouts')
    producer.publish_message(queue.name, payload.to_json)
    producer.close_connection
  end
end
