require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "spec"
  t.libs << "lib"
  t.test_files = FileList["spec/**/*_spec.rb"]
end

task :default => :test

MIGRATION_DIR = "migrate".freeze

migrate = lambda do |env, version|
  ENV["RACK_ENV"] = env
  require_relative "db"
  require "logger"
  Sequel.extension :migration
  DB.loggers << Logger.new($stdout) if DB.loggers.empty?
  Sequel::Migrator.apply(DB, MIGRATION_DIR, version)
end

task :migrate do
  migrate.call("development", nil)
end

task :down do
  migrate.call("development", 0)
end
