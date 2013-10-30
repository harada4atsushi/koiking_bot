$:.unshift File.dirname(__FILE__)
require "./src/koiking"
require "active_record"
require "twitter"

describe 'Koiking' do
  before do
    config = YAML.load_file( 'config.yml' )
    $mode = config["mode"]
    ActiveRecord::Base.establish_connection(config["db"][$mode])

    Twitter.configure do |cnf|
      cnf.consumer_key = config["twitter"][$mode]["consumer_key"]
      cnf.consumer_secret = config["twitter"][$mode]["consumer_secret"]
      cnf.oauth_token = config["twitter"][$mode]["oauth_token"]
      cnf.oauth_token_secret = config["twitter"][$mode]["oauth_token_secret"]
    end

  end

  describe "#fav" do
    it do
      time_now = Time.local(2012,1,30,18,0,0)
      Time.stub!(:now).and_return(time_now)
      puts Koiking.new.fav
      #puts Koiking.new.fav
      1.should == 1
    end
  end

  #describe "#hop" do
  #  it do
  #    Koiking.new.hop
  #  end
  #end
end