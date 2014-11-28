class Company < ActiveRecord::Base
  include Graphable

  def opencorporates_url
    "https://OpenCorporates.com/companies/#{jurisdiction_code}/#{company_number}"
  end
end
