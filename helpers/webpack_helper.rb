require "net/http"

class App
  WEBPACK_DEV_SERVER = "http://localhost:8080/"

  def webpack_tag(*files)
    files +=  ["runtime.js"] unless webpack_dev_server_up?

    files.map {|f| load_tag f}.join
  end

  def load_tag(filename)
    if filename.end_with?(".js")
      %(<script src="#{webpack_path(filename)}" defer></script>)
    elsif filename.end_with?(".css") && !webpack_dev_server_up?
      %(<link rel="stylesheet" href="#{webpack_path(filename)}">)
    end
  end

  def webpack_path(filename)
    if webpack_dev_server_up?
      webpack_dev_server(filename)
    else
      public_manifest_path(filename)
    end
  end

  def public_manifest_path(fn)
    file = File.read("./public/manifest.json")
    manifest = JSON.parse(file)
    manifest[fn]
  end

  def webpack_dev_server(fn)
    uri = URI(WEBPACK_DEV_SERVER + "manifest.json")
    res = Net::HTTP.get(uri)
    manifest = JSON.parse(res)
    WEBPACK_DEV_SERVER + manifest[fn]
  end

  def webpack_dev_server_up?
    return false unless ENV["RACK_ENV"] == "development"

    @_dev_server_running ||= begin
                               uri = URI(WEBPACK_DEV_SERVER)
                               Net::HTTP.get(uri) != ""
                             rescue
                               false
                             end
  end
end
