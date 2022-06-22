# frozen_string_literal: true

# /app/services/publisher.rb
#
class Publisher
  def self.publish(exchange, message = {})
    x = channel.fanout("connector.#{exchange}")
    x.publish(message.to_json)
  end

  def self.channel
    @channel ||= connection.create_channel
  end

  def self.connection
    @connection ||= Bunny.new.tap(&:start)
  end
end
