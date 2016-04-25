require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/activerecord'
require 'json'
require 'yajl'

module Pgsc
  class App < Sinatra::Application
    register Sinatra::ActiveRecordExtension
    set :json_content_type, :js
    set :json_encoder, Yajl::Encoder
    set :logging, true

    get "/health" do
      [200, ENV["RACK_ENV"]]
    end

    post "/metrics" do
      data = JSON.parse(request.body.read)
      metric = Metric.create!(name: data["name"],
                              unit: data["unit"])

      json metric
    end

    post "/metrics/:id/measurements" do |id|
      data = JSON.parse(request.body.read)
      metric = Metric.find(id)
      minute_epoch = (Time.now.to_i / 60)
      key ="measurement-#{metric.id}-#{minute_epoch}"
      Redis.client.lpush(key, data["value"])
      Aggregate.perform_async(id, minute_epoch, key)
      [200]
    end

    get "/metrics/:id/measurements" do |id|
      json Metric.find(id)
                 .measurements
                 .order(epoch_minute: :desc)
                 .as_json(methods: :measured_at)
    end

    get "/metrics/:id" do |id|
      json Metric.find(id)
    end
  end
end
