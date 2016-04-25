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

    get "/health" do
      [200, ENV["RACK_ENV"]]
    end

    post "/metrics" do
      data = JSON.parse(request.body.read)
      metric = Metric.create!(name: data["name"],
                              unit: data["unit"])

      json metric
    end

    post "/metrics/:id/measurements" do
    end

    get "/metrics/:id" do |id|
      json Metric.find(id)
    end
  end
end
