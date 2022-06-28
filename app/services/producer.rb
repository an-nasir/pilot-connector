# frozen_string_literal: true

class Producer
  attr_accessor :mq_connection, :channel

  def initialize
    @mq_connection = BaseService.new
    mq_connection.start
    @channel = mq_connection.create_channel
  end

  def declare_queue(queue_name = 'default', durable: true)
    @channel.queue(queue_name, durable: durable)
  end

  # persistent: true it tells RabbitMQ to save the message to disk
  # @param [routing_key] persistent
  # @param [persistent]
  # @param [msg]
  def publish_message(routing_key, msg, persistent: false)
    Rails.logger.info " message #{msg}"
    @channel.default_exchange.publish(msg, routing_key: routing_key, persistent: persistent)
  end

  def close_connection
    @mq_connection.close
  end
end
