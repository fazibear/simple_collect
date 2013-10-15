#!/usr/bin/env ruby
require_relative 'lib/init'

hosts = YAML.load(
          File.new(
            File.expand_path("../config/ssh_hosts.yml", __FILE__)
          )
        )

hosts.each do |host|
  executor = SshExecutor.new(host['name'], host['host'], host['user'], host['pass'])
  
  MemoryCollector.new.collect!(executor)
  LoadAverageCollector.new.collect!(executor)
end
