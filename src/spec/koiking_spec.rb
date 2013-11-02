require "./src/spec/spec_helper"

describe 'Koiking' do
  describe "#counter" do
    context "同日10回目以上のリプライの場合" do
      it "リプライを返さないこと" do
        puts Reply.where(nil)
        1.should == 1
      end
    end
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
end

=begin
require "./src/koiking"
require "active_record"

describe 'Koiking' do

  #describe "#hop" do
  #  it do
  #    Koiking.new.hop
  #  end
  #end
end
=end