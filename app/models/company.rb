class Company < ActiveRecord::Base
  include Graphable

  def opencorporates_url
    "https://OpenCorporates.com/companies/#{jurisdiction_code}/#{company_number}"
  end

  def beneficial_owner_name
    ultimate_parent_id = get_parent_relationships_for_node(self)[:nodes].select {|x|
      x[:type] = "Person"
    }.last[:id][/\d+/]
    Person.find(ultimate_parent_id).name
  end

  def beneficial_owner_sentence
    "#{self.name} is controlled by #{self.beneficial_owner_name}"
  end
end
