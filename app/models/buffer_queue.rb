# frozen_string_literal: true

class BufferQueue
  attr_reader :max_batch_size, :execution_interval, :timeout_interval, :callback
  def initialize(max_batch_size: 100, execution_interval: 60, timeout_interval: 60, &callback)
    @max_batch_size = max_batch_size
    @execution_interval = execution_interval
    @timeout_interval = timeout_interval
    @queue = Queue.new
    @timer = Concurrent::TimerTask.new(execution_interval: execution_interval, timeout_interval: timeout_interval) do
      flush
    end
    @timer.execute
    @callback = callback
    at_exit { shutdown }
  end

  def flush
    batch = []
    max_batch_size.times do
      if not @queue.empty?
        batch << @queue.pop
      else
        break
      end
    end
    callback.call(batch) unless batch.empty?
  end

  def push(item)
    @queue << item
    if @queue.size >= max_batch_size
      flush
    end
    item
  end

  def shutdown
    puts "shutdown ..."
    @timer.shutdown
    flush
  end
end
