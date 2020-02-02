require_relative "app"
# Allows overriding HTTP request using `_method` params
# eg _method="delete"
# use Rack::MethodOverride

run App.freeze.app
