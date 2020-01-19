env = ENV["RACK_ENV"] || "development"

if env == "production"
  require "dotenv"

  Dotenv.load(".env", ".env.##{env}")
end

require "sequel"

DB = Sequel.connect(ENV.delete("DATABASE_URL"))

DB.extension :looser_typecasting
