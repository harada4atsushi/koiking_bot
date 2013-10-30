# -*- mode:ruby; coding:utf-8 -*-
$:.unshift File.dirname(__FILE__)
require "active_record"
require "twitter"
require "src/koiking"
require "src/models/reply"
require "src/models/mst_level"

puts "start test"

config = YAML.load_file( 'config.yml' )
$mode = config["mode"]
ActiveRecord::Base.establish_connection(config["db"][$mode])

Twitter.configure do |cnf|
  cnf.consumer_key = config["twitter"][$mode]["consumer_key"]
  cnf.consumer_secret = config["twitter"][$mode]["consumer_secret"]
  cnf.oauth_token = config["twitter"][$mode]["oauth_token"]
  cnf.oauth_token_secret = config["twitter"][$mode]["oauth_token_secret"]
end

koiking = Koiking.new
koiking.hop

