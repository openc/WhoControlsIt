require "net/http"


namespace :countries do
  desc "Import Countries"
  task :import_countries do
    filename = 'config/countries.json'
    open(filename, 'w') do |file|
      response = Net::HTTP.get_response(URI.parse("http://api.opencorporates.com/jurisdictions"))
      file << response.body
    end
  end
end
