module Pgsc
  class Aggregate
    include Sidekiq::Worker

    sidekiq_options retry: false, queue: :high

    def perform(id, epoch, key)
      metric = Metric.find_by_id(id)
      return unless metric
      metric.with_lock do
        measurement = metric.measurements
                            .where(epoch_minute: epoch)
                            .first_or_initialize
        return if measurement.count == Redis.client.llen(key)
        data = Redis.client.lrange(key, 0, -1).map(&:to_f).sort
        return if data.empty?
        sum = data.sum
        measurement.update!(min: data.first,
                            max: data.last,
                            sum: sum,
                            median: calc_median(data),
                            count: data.length,
                            avg: sum / data.length,
                            ninety_five: data[(data.length * 0.95).to_i],
                            ninety_nine: data[(data.length * 0.99).to_i])

        Redis.client.expire(key, 60 * 10)
      end
    end

    private

    def calc_median(array)
      (array[(array.length - 1) / 2] + array[array.length / 2]) / 2.0
    end
  end
end
