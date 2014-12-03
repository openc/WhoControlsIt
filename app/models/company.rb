class Company < ActiveRecord::Base
  include Graphable

  def opencorporates_url
    "https://OpenCorporates.com/companies/#{jurisdiction_code}/#{company_number}"
  end

  def beneficial_owner_name
    prs = Array(self.parent_control_relationships).last
    if prs
      prs.parent.name
    else
      "no one"
    end
  end

  def beneficial_owner_sentence
    "#{self.name} is controlled by #{self.beneficial_owner_name}"
  end
end
