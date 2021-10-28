# frozen_string_literal: true

# just attempt to write async worker
class MyWorker
  include Sidekiq::Worker
  def perform
    puts 'Hello from my Worker!'
  end
end
