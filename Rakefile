# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

namespace :rabbitmq do
  desc 'Setup routing'
  task setup: :environment do
    require 'bunny'

    conn = Bunny.new
    conn.start
    ch = conn.create_channel
    # multiple exchanges
    con_x = ch.fanout('connector.payment_requests')
    man_x = ch.fanout('manager.payment_requests')

    # bound to same queue to share data in
    queue = ch.queue('manager.payment_requests', durable: true).bind(con_x.name)
    queue = ch.queue('manager.payment_requests', durable: true).bind(man_x.name)
    conn.close
  end
end
