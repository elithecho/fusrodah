migrate = lambda do |env, version|
  ENV["RACK_ENV"] = env
  require_relative "db"
  require "logger"
  Sequel.extension :migration
  DB.loggers << Logger.new($stdout) if DB.loggers.empty?
  Sequel::Migrator.apply(DB, "migrate", version)
end

task :migrate do
  migrate.call("development", nil)
end

task :down do
  migrate.call("development", 0)
end
