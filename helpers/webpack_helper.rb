require "net/http"

class App
  WEBPACK_DEV_SERVER = "http://localhost:8080/"

  def webpack_script_tag(fn)
    files = fn.is_a?(Array) ? fn : [fn]
    files +=  ["runtime.js"] unless webpack_dev_server_up?
    files.map{ |f| load_tag(f, :js) }.join
  end

  def webpack_stylesheet_tag(fn)
    return "" if webpack_dev_server_up?

    files = fn.is_a?(Array) ? fn : [fn]
    files.map{ |f| load_tag(f, :css) }.join
  end

  def load_tag(fn, type)
    if type == :js
      %(<script src="#{webpack_path(fn)}"></script>)
    else
      %(<link rel="stylesheet" href="#{webpack_path(fn)}">)
    end
  end

  def webpack_path(fn)
    if webpack_dev_server_up?
      webpack_dev_server(fn)
    else
      public_manifest_path(fn)
    end
  end

  def public_manifest_path(fn)
    file = File.read("./public/manifest.json")
    manifest = JSON.parse(file)
    timestamp_path(manifest[fn])
  end

  def webpack_dev_server(fn)
    uri = URI(WEBPACK_DEV_SERVER + "manifest.json")
    res = Net::HTTP.get(uri)
    manifest = JSON.parse(res)
    WEBPACK_DEV_SERVER + manifest[fn]
  end

  def webpack_dev_server_up?
    return false unless ENV["RACK_ENV"] == "development"

    begin
      uri = URI(WEBPACK_DEV_SERVER)
      Net::HTTP.get(uri) != ""
    rescue
      false
    end
  end
end
