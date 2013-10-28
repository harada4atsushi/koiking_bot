# -*- mode:ruby; coding:utf-8 -*-
$:.unshift File.dirname(__FILE__)
require "active_record"
require "src/migrations/create_table_replies"

config = YAML.load_file( 'config.yml' )
$mode = config["mode"]
ActiveRecord::Base.establish_connection(config["db"][$mode])

class_name = ARGV[0]
unless class_name
  puts "引数にmigrationクラス名を指定してください"
  exit
end

#method = ARGV[1]

Object.const_get(class_name).new.up
#CreateTableReplies.new.down




