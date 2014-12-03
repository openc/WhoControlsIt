class Company < ActiveRecord::Base
  include Graphable

  def opencorporates_url
    "https://OpenCorporates.com/companies/#{jurisdiction_code}/#{company_number}"
  end

  def beneficial_owner_name
    self.parent_control_relationships.select {|x| x.parent_type = 'Person' }.last.parent.name
  end

  def beneficial_owner_sentence
    "#{self.name} is controlled by #{self.beneficial_owner_name}"
  end
end
