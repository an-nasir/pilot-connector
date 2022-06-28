# frozen_string_literal: true

# acts as base bunny connection and channel
# connection start etc
class BaseService
  attr_accessor :connection, :channel, :default_queue

  def initialize(auto_recover: false)
    @connection = Bunny.new(automatically_recover: auto_recover)
  end

  delegate :start, to: :connection
  delegate :close, to: :connection

  def create_channel
    @channel = connection.create_channel
  end
end
