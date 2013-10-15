require 'bundler'
Bundler.require(:default)

require_relative 'executors/localhost_executor'
require_relative 'executors/ssh_executor'

require_relative 'collectors/memory_collector'
require_relative 'collectors/load_average_collector'

DataMapper::Logger.new('log/database.log', :debug) #if $DEBUG

env = ENV['env'] || 'development'
file = File.expand_path("../../config/database.yml", __FILE__)
database = YAML.load(File.new(file))

DataMapper.setup(:default, database[env])
DataMapper.finalize
DataMapper.auto_upgrade!

