require "./lib/pgsc"
require "sidekiq/web"

run Rack::URLMap.new('/' => Pgsc::App, '/sidekiq' => Sidekiq::Web)
