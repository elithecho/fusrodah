env = ENV["RACK_ENV"] || "development"

if %w[development test].include?(env)
  require "dotenv"

  Dotenv.load(".env", ".env.#{env}")
end

