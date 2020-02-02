require "roda"
require_relative "./models"

class App < Roda
  plugin :all_verbs
  plugin :timestamp_public
  plugin :json
  plugin :render, engine: "slim"
  plugin :symbol_views
  plugin :symbolized_params

  route do |r|
    r.timestamp_public

    r.root do
      view :home
    end
  end
end
