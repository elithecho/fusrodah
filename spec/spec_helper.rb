require "warning"

test_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(test_dir)

Warning.ignore(/instance variable @\w+ not initialized/)
Warning.ignore(/statement not reached/)

ENV["RACK_ENV"] = "test"
require_relative "../models"

raise "test database doesn't end with test" unless DB.opts[:database] =~ /test\z/

require "minitest_helper"
