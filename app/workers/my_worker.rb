class MyWorker 
    include Sidekiq::Worker

    def perform
        puts " Hello from my Worker!"
    end
end