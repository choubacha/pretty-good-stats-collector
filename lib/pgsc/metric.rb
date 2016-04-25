require 'sinatra/activerecord'

module Pgsc
  class Metric < ActiveRecord::Base
    enum unit: [:millesecond]
  end
end
