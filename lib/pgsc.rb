require "sidekiq"

module Pgsc
end

require_relative "pgsc/metric"
require_relative "pgsc/measurement"
require_relative "pgsc/redis"
require_relative "pgsc/aggregate"
require_relative "pgsc/app"

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end
