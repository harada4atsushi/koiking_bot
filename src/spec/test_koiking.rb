# -*- mode:ruby; coding:utf-8 -*-
$:.unshift "src"

require "koiking"
require "test/app_test_case"
require "twitter"
require 'yaml'

class TC_Koiking < AppTestCase
  
  def setup
    config = YAML.load_file("config.yml")
    @koiking = Koiking.new
    @twitter = TwitterAccesser.new
    @db_accesser = DBAccesser.new
    @koiking.db_accesser = @db_accesser
    Twitter.configure do |cnf|
      cnf.consumer_key = config["twitter_test"]["consumer_key"]
      cnf.consumer_secret = config["twitter_test"]["consumer_secret"]
      cnf.oauth_token = config["twitter_test"]["oauth_token"]
      cnf.oauth_token_secret = config["twitter_test"]["oauth_token_secret"]
    end
  end

  # def teardown
  # end

  def test_counter
    Twitter.update("@koiking__bot ハイドロポンプ #{Time.now}")
    sleep(10)
    assert_match_with_stdout("コイキングの攻撃") do
      @koiking.counter(@twitter.mentions[0])
    end
  end

  def test_show_contributors
    6.times { |i|
      @db_accesser.insert_replies({:screen_name => "test#{i}", :added_exp => rand(50)})
    }
    # 2回つぶやく
    assert_match_with_stdout(/.*最近たくさん育ててくれた人(.|\n)*経験値(.|\n)*最近たくさん育ててくれた人(.|\n)*経験値.*/) do
      @koiking.show_contributors
    end
  end

  def test_evolve
    @koiking.evolve
  end

end
  