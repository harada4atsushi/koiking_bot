# -*- mode:ruby; coding:utf-8 -*-
require 'test/unit'

class AppTestCase < Test::Unit::TestCase
  
  def assert_match_with_stdout(expected)
    $stdout = StringIO.new
    begin
      yield
      $stdout.rewind 
      assert_match expected, $stdout.read
    ensure
      $stdout.close
      $stdout = STDOUT
    end
  end
  
end