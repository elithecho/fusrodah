env = ENV["RACK_ENV"] || "development"

if env != "production"
  require "dotenv"

  Dotenv.load(".env", ".env.##{env}")
end

require "sequel/core"

# Delete APP_DATABASE_URL from the environment, so it isn't accidently
# passed to subprocesses.  APP_DATABASE_URL may contain passwords.

DB= if env == "development" || env == "test"
      Sequel.sqlite("database.db")
    else
      Sequel.connect(ENV.delete("DATABASE_URL"))
    end
