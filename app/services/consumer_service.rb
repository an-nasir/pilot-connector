class ConsumerService
  attr_accessor :mq_connection, :channel

  def initialize
    @mq_connection = BaseService.new
    mq_connection.start
    @channel = mq_connection.create_channel

    # It’s a simple way to do load-balancing
    # channel wide for consumers which have manual_ack
    @channel.prefetch(2)
  end

  def declare_queue(queue_name = 'default', durable: false)
    Rails.logger.info "queue with name #{queue_name} created"
    @channel.queue(queue_name, durable: durable)
  end

  def consume_message(queue)
    begin
      # manual_ack: as we used prefetch, manual acknowledgment
      # If ack not received RabbitMQ will re-queue it
      msg = nil
      queue.subscribe(manual_ack: true, block: true) do |delivery_info, _properties, payload|
        channel.ack(delivery_info.delivery_tag)
        msg = payload
        # close_connection
      end
      return msg
    rescue Interrupt => _e
      close_connection
    end
    false
  end

  def close_connection
    mq_connection.close
  end
end
