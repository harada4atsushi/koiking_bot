# -*- mode:ruby; coding:utf-8 -*-
class Koiking

  def initialize
    infile = open("dictionary", "r:UTF-8")
    @dictionary = infile.readlines
  end

  def counter_all
    mentions = Twitter.mentions
    mentions.each do |t|
      counter t
    end
  end

  def counter(t)
    return unless t.id > (Reply.maximum(:status_id) || 0)
    # 前日以降のリプライのみ対応
    return unless t.created_at.to_date >= Date.today - 1
    # 1日5回まで
    return if 5 < Reply.where(["strftime('%Y%m%d', created_at) = ? and screen_name = ?",
      Time.now().strftime("%Y%m%d"), t.user.screen_name]).count

    if contain_method_name?(t.text)
      before_level = level
      exp = rand(30) + 1
      Reply.create(:status_id => t.id, :screen_name => t.user.screen_name, :added_exp => exp)

      # リプライ文
      str = "@#{t.user.screen_name} コイキングの攻撃、「はねる」\n"
      str << "ぴちっ！ぴちっ！\n"
      str << "しかしなにもおこらない。\n"
      str << "\n"
      str << "コイキングは経験値#{exp}をもらった。"
      if before_level < level
        str << "\n\nコイキングは\nレベル#{level}　に　あがった！"
        Twitter.update_profile(:name => "コイキングbot（レベル#{level}）")
        #if now_level == 100
          #self.evolve
        #end
      end
      str << "\n"
      str << "現在の経験値：#{total_exp}"
    else
      # 技リストに存在しない
      str = "@#{t.user.screen_name} " + ("・" * (rand(4) + 3))
      str << "　" * rand(20)
      Reply.create(:status_id => t.id, :screen_name => t.user.screen_name, :added_exp => 0)
    end
    Twitter.update(str, :in_reply_to_status_id => t.id)
  end

  def fav
    str = "コイキング -RT"
    Twitter.search(str).statuses.select{|t| t.user.screen_name != "koiking__bot" && !t.favorited}
      .each_with_index do |t, index|
      break if index >= 3
      Twitter.favorite(t.id)
    end
  end

  # 60m * 24h / 3m = 480 (3分おきにcron設定した場合に1日に1回程度つぶやく)
  def hop
    per = rand(480)
    cnt = rand(4) + 1
    Twitter.update("ﾋﾟﾁｯ" * cnt + "!!") if per == 0
  end

  private
  def contain_method_name?(replay)
    arr = @dictionary.select{|d|
      replay = Moji.han_to_zen(replay.encode('utf-8'))
      !replay.index(d.chomp).nil?
     }
    arr.length > 0
  end

  def total_exp
    Reply.sum(:added_exp)
  end

  def level
    MstLevel.where("total_exp <= ?", total_exp).order("level desc").first.level
  end

=begin
  def initialize
    config = YAML.load_file("config.yml")
    @twitter = TwitterAccesser.new
    @debug_flg = config["debug"]
  end

  def db_accesser=(db_accesser)
    @db_accesser = db_accesser
  end



  def level(exp = nil)
    @db_accesser.get_level(exp)
  end

  def counter(t)
    level = self.level
    exp = rand(30) + 1
    total_exp = @db_accesser.add_exp(exp)
    now_level = self.level(total_exp)
    if level < now_level
      levelup_str = "\n\nコイキングは\nレベル#{now_level}　に　あがった！\n"
      self.name = "コイキングbot（レベル#{now_level}）"
      if now_level == 100
        self.evolve
      end
    end
    str = "@#{t.user.screen_name} コイキングの攻撃、「はねる」\n"
    str << "ぴちっ！ぴちっ！\n"
    str << "しかしなにもおこらない。\n"
    str << "\n"
    str << "コイキングは経験値#{exp}をもらった。#{levelup_str}\n"
    str << "現在の経験値：#{total_exp}"

    @db_accesser.insert_replies({:screen_name => t.user.screen_name, :added_exp => exp})
    @twitter.update(str, t.id)
  end

  def show_contributors
    contributor = ""
    arr = @db_accesser.get_contributors
    arr.each_with_index do |rec, i|
      contributor << "@#{rec[0]} さん　経験値：#{rec[1]}\n"
      if (i + 1) % 3 == 0
        str = "ﾋﾟﾁｯﾋﾟﾁｯ!!（\n"
        str << "最近たくさん育ててくれた人…\n"
        str << contributor
        str << "どうもありがとう…）"
        @twitter.update(str)
        contributor = ""
      end
    end
  end

  def evolve
    sleep(@debug_flg ? 10 : 300)
    @twitter.update("おや！？コイキングのようすが・・・！")
    sleep(@debug_flg ? 10 : 300)
    str = "みんなのおかけでコイキングはギャラドスになれたよ！ありがとう！"
    str << "もし、もう少し遊びたい方いましたら中の人にハイドロポンプしてみてください。"
    str << "もしかしたらコイキング復活するかもね。 中の人→@harada4atsushi"
    img_file = open("./images/koiking_2.jpeg")
    @twitter.update_name("ギャラドスbot")
    @twitter.update_profile_description(str)
    @twitter.update_profile_image(img_file)
  end
=end
end