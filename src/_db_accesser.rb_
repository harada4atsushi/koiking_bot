require "sqlite3"

class DBAccesser
  
  DB_NAME = "koiking_db.sqlite"

  def initialize
    @db = SQLite3::Database.open DB_NAME
  end

  def get_last_twid
    rows = @db.execute("select * from status")  
    return rows[0][0]
  end

  def upd_last_twid(id)
    @db.execute("update status set last_twid = ?", id)
  end

  def add_exp(exp)
    @db.execute("update status set exp = exp + ?", exp)
    rows = @db.execute("select exp from status")
    return rows[0][0]
  end
  
  def get_level(exp = nil)
    unless exp
      row = @db.get_first_row("select exp from status")
      exp = row[0]
    end
    row = @db.get_first_row("select level from mst_level where total_exp <= ? order by total_exp desc limit 1", exp)
    return row[0]
  end
  
  def exists_col?(tbl_name, col_name)
    rows = db.execute("PRAGMA table_info(?)", tbl_name)
    rows.each do |row|
      return true if row[1] == col_name
    end
    false
  end
  
  def get_contributors
    sql = "select screen_name, sum(added_exp) from replies where created_at >= date('now', 'localtime', '-5 days') "
    sql << "group by screen_name order by sum(added_exp) desc limit 3"
    rows = @db.execute(sql)  
  end
  
  def insert_replies(values)
    sql = "insert into replies (screen_name, added_exp, created_at) values "
    sql << "('#{values[:screen_name]}', #{values[:added_exp]}, date('now', 'localtime'))"
    @db.execute(sql)
  end
  
  def close
    @db.close
  end
  
  def self.migrate_db
    db = SQLite3::Database.open DB_NAME
    
    # create status table
    result = db.get_first_row("select count(*) from sqlite_master where type='table' and name = 'status'");
    if result[0] == 0
      puts "create status table start"
      db.execute("create table status (last_twid integer, exp integer);")
      db.execute("insert into status (last_twid, exp) values (1, 0);")
    end
 
    # create replies table
    result = db.get_first_row("select count(*) from sqlite_master where type='table' and name = 'replies'");
    if result[0] == 0
      puts "create replies table start"
      db.execute("create table replies (screen_name, added_exp, created_at);")
    end
    
    # create mst_level table
    result = db.get_first_row("select count(*) from sqlite_master where type='table' and name = 'mst_level'");
    if result[0] == 0
      puts "create mst_level"
      db.execute("create table mst_level (level integer, total_exp integer)")
    end
    db.execute("delete from mst_level")
    db.execute("insert into mst_level (level, total_exp) values (1,0)")
    db.execute("insert into mst_level (level, total_exp) values (2,224)")
    db.execute("insert into mst_level (level, total_exp) values (3,448)")
    db.execute("insert into mst_level (level, total_exp) values (4,672)")
    db.execute("insert into mst_level (level, total_exp) values (5,896)")
    db.execute("insert into mst_level (level, total_exp) values (6,1120)")
    db.execute("insert into mst_level (level, total_exp) values (7,1344)")
    db.execute("insert into mst_level (level, total_exp) values (8,1568)")
    db.execute("insert into mst_level (level, total_exp) values (9,1792)")
    db.execute("insert into mst_level (level, total_exp) values (10,2016)")
    db.execute("insert into mst_level (level, total_exp) values (11,2240)")
    db.execute("insert into mst_level (level, total_exp) values (12,2464)")
    db.execute("insert into mst_level (level, total_exp) values (13,2688)")
    db.execute("insert into mst_level (level, total_exp) values (14,2912)")
    db.execute("insert into mst_level (level, total_exp) values (15,3136)")
    db.execute("insert into mst_level (level, total_exp) values (16,3360)")
    db.execute("insert into mst_level (level, total_exp) values (17,3584)")
    db.execute("insert into mst_level (level, total_exp) values (18,3808)")
    db.execute("insert into mst_level (level, total_exp) values (19,4032)")
    db.execute("insert into mst_level (level, total_exp) values (20,4256)")
    db.execute("insert into mst_level (level, total_exp) values (21,4480)")
    db.execute("insert into mst_level (level, total_exp) values (22,4704)")
    db.execute("insert into mst_level (level, total_exp) values (23,4928)")
    db.execute("insert into mst_level (level, total_exp) values (24,5152)")
    db.execute("insert into mst_level (level, total_exp) values (25,5376)")
    db.execute("insert into mst_level (level, total_exp) values (26,5796)")
    db.execute("insert into mst_level (level, total_exp) values (27,6216)")
    db.execute("insert into mst_level (level, total_exp) values (28,6636)")
    db.execute("insert into mst_level (level, total_exp) values (29,7056)")
    db.execute("insert into mst_level (level, total_exp) values (30,7476)")
    db.execute("insert into mst_level (level, total_exp) values (31,7896)")
    db.execute("insert into mst_level (level, total_exp) values (32,8316)")
    db.execute("insert into mst_level (level, total_exp) values (33,8736)")
    db.execute("insert into mst_level (level, total_exp) values (34,9156)")
    db.execute("insert into mst_level (level, total_exp) values (35,9576)")
    db.execute("insert into mst_level (level, total_exp) values (36,9996)")
    db.execute("insert into mst_level (level, total_exp) values (37,10416)")
    db.execute("insert into mst_level (level, total_exp) values (38,10836)")
    db.execute("insert into mst_level (level, total_exp) values (39,11256)")
    db.execute("insert into mst_level (level, total_exp) values (40,12516)")
    db.execute("insert into mst_level (level, total_exp) values (41,13776)")
    db.execute("insert into mst_level (level, total_exp) values (42,15036)")
    db.execute("insert into mst_level (level, total_exp) values (43,16296)")
    db.execute("insert into mst_level (level, total_exp) values (44,17556)")
    db.execute("insert into mst_level (level, total_exp) values (45,18816)")
    db.execute("insert into mst_level (level, total_exp) values (46,20076)")
    db.execute("insert into mst_level (level, total_exp) values (47,21336)")
    db.execute("insert into mst_level (level, total_exp) values (48,22596)")
    db.execute("insert into mst_level (level, total_exp) values (49,23856)")
    db.execute("insert into mst_level (level, total_exp) values (50,25116)")
    db.execute("insert into mst_level (level, total_exp) values (51,26376)")
    db.execute("insert into mst_level (level, total_exp) values (52,27636)")
    db.execute("insert into mst_level (level, total_exp) values (53,28896)")
    db.execute("insert into mst_level (level, total_exp) values (54,30156)")
    db.execute("insert into mst_level (level, total_exp) values (55,31416)")
    db.execute("insert into mst_level (level, total_exp) values (56,32676)")
    db.execute("insert into mst_level (level, total_exp) values (57,33936)")
    db.execute("insert into mst_level (level, total_exp) values (58,35196)")
    db.execute("insert into mst_level (level, total_exp) values (59,36456)")
    db.execute("insert into mst_level (level, total_exp) values (60,37716)")
    db.execute("insert into mst_level (level, total_exp) values (61,38976)")
    db.execute("insert into mst_level (level, total_exp) values (62,40236)")
    db.execute("insert into mst_level (level, total_exp) values (63,41916)")
    db.execute("insert into mst_level (level, total_exp) values (64,43596)")
    db.execute("insert into mst_level (level, total_exp) values (65,45276)")
    db.execute("insert into mst_level (level, total_exp) values (66,46956)")
    db.execute("insert into mst_level (level, total_exp) values (67,48636)")
    db.execute("insert into mst_level (level, total_exp) values (68,50316)")
    db.execute("insert into mst_level (level, total_exp) values (69,51996)")
    db.execute("insert into mst_level (level, total_exp) values (70,53676)")
    db.execute("insert into mst_level (level, total_exp) values (71,55356)")
    db.execute("insert into mst_level (level, total_exp) values (72,57036)")
    db.execute("insert into mst_level (level, total_exp) values (73,58716)")
    db.execute("insert into mst_level (level, total_exp) values (74,60396)")
    db.execute("insert into mst_level (level, total_exp) values (75,62076)")
    db.execute("insert into mst_level (level, total_exp) values (76,63756)")
    db.execute("insert into mst_level (level, total_exp) values (77,65436)")
    db.execute("insert into mst_level (level, total_exp) values (78,67116)")
    db.execute("insert into mst_level (level, total_exp) values (79,68796)")
    db.execute("insert into mst_level (level, total_exp) values (80,70476)")
    db.execute("insert into mst_level (level, total_exp) values (81,72156)")
    db.execute("insert into mst_level (level, total_exp) values (82,73836)")
    db.execute("insert into mst_level (level, total_exp) values (83,75796)")
    db.execute("insert into mst_level (level, total_exp) values (84,77756)")
    db.execute("insert into mst_level (level, total_exp) values (85,79716)")
    db.execute("insert into mst_level (level, total_exp) values (86,81676)")
    db.execute("insert into mst_level (level, total_exp) values (87,83636)")
    db.execute("insert into mst_level (level, total_exp) values (88,85876)")
    db.execute("insert into mst_level (level, total_exp) values (89,88116)")
    db.execute("insert into mst_level (level, total_exp) values (90,90356)")
    db.execute("insert into mst_level (level, total_exp) values (91,92596)")
    db.execute("insert into mst_level (level, total_exp) values (92,94836)")
    db.execute("insert into mst_level (level, total_exp) values (93,97636)")
    db.execute("insert into mst_level (level, total_exp) values (94,100716)")
    db.execute("insert into mst_level (level, total_exp) values (95,104076)")
    db.execute("insert into mst_level (level, total_exp) values (96,107716)")
    db.execute("insert into mst_level (level, total_exp) values (97,111636)")
    db.execute("insert into mst_level (level, total_exp) values (98,115836)")
    db.execute("insert into mst_level (level, total_exp) values (99,120316)")
    db.execute("insert into mst_level (level, total_exp) values (100,125076)")
    db.close
  end
 
end
