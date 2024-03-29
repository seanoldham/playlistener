$LOAD_PATH.unshift(File.dirname(__FILE__))

ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require :default, ENV['RACK_ENV']

require 'slack-ruby-bot-server'
require 'playlistener'
require 'rspotify'

Mongoid.load!(File.expand_path('config/mongoid.yml', __dir__), ENV['RACK_ENV'])

SlackRubyBotServer::App.instance.prepare!

Thread.new do
  SlackRubyBotServer::Service.start!
  SlackRubyBotServer::Service.instance.run_periodic_timer!
end

run SlackRubyBotServer::Api::Middleware.instance
