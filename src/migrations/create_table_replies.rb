# coding: utf-8
class CreateTableReplies < ActiveRecord::Migration
  def up
    create_table :replies do |t|
      t.integer :status_id, :limit => 30
      t.string :screen_name
      t.integer :added_exp
      t.timestamps
    end
  end

  def down
    drop_table :replies
  end
end