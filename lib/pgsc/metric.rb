require 'sinatra/activerecord'

module Pgsc
  class Metric < ActiveRecord::Base
    enum unit: [:millesecond]

    has_many :measurements
  end
end
