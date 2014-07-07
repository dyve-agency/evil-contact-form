require 'rubygems'
require 'bundler'

Bundler.require

if production?
  require "dotenv/deployment"
end

require './app.rb'
run Sinatra::Application
