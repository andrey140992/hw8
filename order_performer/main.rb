require 'eventmachine'
require 'bunny'

puts 'loading...'

def really_slow_task(payload)
  puts 'Starting really slow task!'

  4.times do
    putc '.'
    sleep 1
  end
  puts

  puts "Payload: #{payload}"

  puts 'Slow task finished'
  'Order is performed successfully'
end

puts "before running"
EventMachine.run do
  puts "\n\n starting EventMachine"
  connection = Bunny.new('amqp://guest:guest@rabbitmq')
  connection.start

  channel = connection.create_channel
  queue = channel.queue('vm.control', auto_delete: true)
  exchange = channel.default_exchange

  queue.subscribe do |delivery_info, metadata, payload|
    puts "new message"
    result = really_slow_task(payload)

    exchange.publish(
      result.to_s,
      routing_key: metadata.reply_to,
      correlation_id: metadata.correlation_id
    )
  end

  Signal.trap('INT') do
    puts 'exiting INT'
    connection.close { EventMachine.stop }
  end

  Signal.trap('TERM') do
    puts 'killing TERM'
    connection.close { EventMachine.stop }
  end

  puts "EventMachine has started \n\n"
end