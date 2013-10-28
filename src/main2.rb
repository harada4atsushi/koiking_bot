# -*- mode:ruby; coding:utf-8 -*- 
$:.unshift File.dirname(__FILE__)

require "db_accesser"
require "koiking"

puts "start main2"
koiking = Koiking.new

config = YAML.load_file("config.yml")
@debug_flg = config["debug"]

# 5時間以内でランダム実行
sec = @debug_flg ? rand(10) : rand(18000)
sleep rand(sec)

begin 
  db_accesser = DBAccesser.new
  koiking.db_accesser = db_accesser
  koiking.show_contributors
ensure
  db_accesser.close if defined?(db_accesser)
end