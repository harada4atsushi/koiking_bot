$:.unshift File.dirname(__FILE__)
require "./src/koiking"
require "active_record"
require "twitter"

describe 'Koiking' do
  before do
    #config = YAML.load_file( 'config.yml' )
    #$mode = config["mode"]
    #ActiveRecord::Base.establish_connection(config["db"][$mode])

    #Twitter.configure do |cnf|
    #  cnf.consumer_key = config["twitter"][$mode]["consumer_key"]
    #  cnf.consumer_secret = config["twitter"][$mode]["consumer_secret"]
    #  cnf.oauth_token = config["twitter"][$mode]["oauth_token"]
    #  cnf.oauth_token_secret = config["twitter"][$mode]["oauth_token_secret"]
    #end

  end

  describe "#fav" do
    it do
      user1 = Twitter::User.new(:id => 1)
      user1.stub(:screen_name).and_return("harada4atsushi")
      user2 = Twitter::User.new(:id => 2)
      user2.stub(:screen_name).and_return("koiking__bot")
      tweet1 = Twitter::Tweet.new(:id => 10)
      tweet1.stub(:user).and_return(user1)
      tweet2 = Twitter::Tweet.new(:id => 11)
      tweet2.stub(:user).and_return(user2)

      results = Twitter::SearchResults.new
      results.stub(:statuses).and_return([tweet1, tweet2])
      Twitter.stub(:search).and_return(results)
      Twitter.stub(:favorite)
      Twitter.should_receive(:favorite).exactly(1)
      Koiking.new.fav
    end
  end

  #describe "#hop" do
  #  it do
  #    Koiking.new.hop
  #  end
  #end
end