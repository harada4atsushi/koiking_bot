# -*- mode:ruby; coding:utf-8 -*-
$:.unshift File.dirname(__FILE__)
require "active_record"
require "twitter"
require "src/koiking"
require "moji"

Dir[File.join(File.dirname(__FILE__), "src", "models", "**/*.rb")].each do |f|
  require f
end

unless ARGV[0].nil?
  unless ["hop", "fav"].include?(ARGV[0])
    puts "無効な引数が指定されています"
    exit
  end
end

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

if ARGV[0].nil?
  koiking.counter_all
else
  koiking.send(ARGV[0])
end




# はねる
#koiking.hop

# ふぁぼ
#oiking.fav

=begin
require "db_accesser"
require "twitter_accesser"
require "koiking_util"
require "koiking"

puts "start koiking_bot_task"
twitter = TwitterAccesser.new
koiking = Koiking.new



infile = open("dictionary", "r:UTF-8")
dictionary = infile.readlines

begin
  db_accesser = DBAccesser.new
  koiking.db_accesser = db_accesser
  last_twid = db_accesser.get_last_twid
  mentions = twitter.mentions
  db_accesser.upd_last_twid(mentions[0].id) if defined?(mentions)

  mentions.select{|t| t.id > last_twid}.each do |t|
    # 前日以降のリプライのみ対応
    if t.created_at.to_date >= Date.today - 1
      # 技リストに存在する
      if KoikingUtil.contain_method_name?(t.text, dictionary)
        koiking.counter(t)
      else
         # 技リストに存在しない
        koiking.replay(t)
      end
    end
  end
ensure
  db_accesser.close if defined?(db_accesser)
end

=end