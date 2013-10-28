# -*- mode:ruby; coding:utf-8 -*-
require "twitter"
require 'yaml'

class TwitterAccesser

=begin
  def initialize
    config = YAML.load_file("config.yml")
    @debug_flg = config["debug"]
    Twitter.configure do |cnf|
      cnf.consumer_key = config["twitter_test"]["consumer_key"]
      cnf.consumer_secret = config["twitter_test"]["consumer_secret"]
      cnf.oauth_token = config["twitter_test"]["oauth_token"]
      cnf.oauth_token_secret = config["twitter_test"]["oauth_token_secret"]
    end
  end

  def update(str, reply_to_id = nil)
    Twitter.update(str, :in_reply_to_status_id => reply_to_id)
  end

  def mentions
    Twitter.mentions
  end

  def search(str)
    Twitter::search(str)
  end

  def favorite(tweet)
    if @debug_flg
      puts "ふぁぼ：#{tweet.id}\n" unless tweet.favorited
    else
      Twitter::favorite(tweet.id) unless tweet.favorited
    end
  end

  def update_name(name)
    if @debug_flg
      puts "名前変更：#{name}\n"
    else
      Twitter.update_profile(:name => name)
    end
  end

  def update_profile_description(desc)
    if @debug_flg
      puts "プロフィール文言変更：#{desc}\n"
    else
      Twitter.update_profile(:description => desc)
    end
  end

  def update_profile_image(img_file)
    #if @debug_flg
      #puts "プロフィール画像変更：#{img_file.path}\n"
    #else
      #Twitter.update_profile_image(img_file)
    #end
  end
=end
end