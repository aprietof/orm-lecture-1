require 'bundler'
Bundler.require

DB = SQLite3::Database.new "db/blog.db"
# other dependencies
require_all 'app'
