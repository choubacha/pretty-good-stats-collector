require 'sinatra/activerecord'

module Pgsc
  class Measurement < ActiveRecord::Base
    belongs_to :metric

    def measured_at
      Time.at(epoch_minute * 60)
    end
  end
end
