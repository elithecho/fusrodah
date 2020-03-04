require_relative "./config/env"
require "sequel"

DB = Sequel.connect(ENV.delete("DATABASE_URL"))

DB.extension :looser_typecasting
