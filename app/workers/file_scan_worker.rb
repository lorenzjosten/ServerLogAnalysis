class FileScanWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  include ScannerModule
  sidekiq_options queue: 'default'
  sidekiq_options retry: false

  def perform(input_file_id)
    input_file = InputFile.find(input_file_id)
    scanner = ScannerModule::Scanner.new(input_file.data)
    Pusher.trigger('my-channel', 'reset', {})
    while scanner.progress < 100 && !cancelled? do
      if match = scanner.next_match
        Pusher.trigger('my-channel', 'update-data', {
          url: match[:url],
          respT: match[:respT],
          date: match[:access_time],
          blog: match[:url].match?(%r{(?<=/)blog(?=/)}),
          date_str: DateTime.parse(match[:access_time]).strftime('%Y-%m-%d')
        })
      end
      Pusher.trigger('my-channel', 'update-progress', { progress: scanner.progress })
    end
  end

  def cancelled?
    Sidekiq.redis {|c| c.exists("cancelled-#{jid}") }
  end

  def self.cancel!(jid)
    Sidekiq.redis {|c| c.setex("cancelled-#{jid}", 86400, 1) }
  end

  def self.working?(jid)
    Sidekiq::Status::working?(jid)
  end

end
