require 'rails_helper'

def make_relationship_params(parent, child, args = {})
  default_args = {
    relationship_type: (child.class.is_a?(Company) ? "Shareholding" : "Nominee")
  }

  default_args.merge(args).merge({
    parent_id: parent.id,
    parent_type: parent.class.to_s,
    child_id: child.id,
    child_type: child.class.to_s,
  })
end

RSpec.describe Company, :type => :model do
  before do
    @baby_m = Company.create(name: "Baby brother corp")
    @baby_f = Company.create(name: "Baby sister corp")
    @mum = Person.create(name: "Mum")
    @aunt = Person.create(name: "Aunt")
    @grand_controller = Person.create(name: "Grand Controller")

    @unrelated_company = Company.create(name: "Amazon LLC")
    @unrelated_nominee = Person.create(name: "Mr. Nominee")
    @unrelated_director = Person.create(name: "Jeff Bezos")
    
    ControlRelationship.create(make_relationship_params(@mum, @baby_m))
    ControlRelationship.create(make_relationship_params(@mum, @baby_f))
    ControlRelationship.create(make_relationship_params(@grand_controller, @mum))
    ControlRelationship.create(make_relationship_params(@grand_controller, @aunt))

    ControlRelationship.create(make_relationship_params(@unrelated_nominee, @unrelated_company))
    ControlRelationship.create(make_relationship_params(@unrelated_director, @unrelated_nominee))
  end

  it "has a name" do
    expect(@baby_m.name).to eq("Baby brother corp")
  end

  it "produces a proper graph with siblings" do
    expect(@baby_m.graph_relationships[:nodes].map{|x| 
      x[:label] 
    }).to match_array(["Grand Controller",
                       "Mum",
                       "Aunt",
                       "Baby brother corp",
                       "Baby sister corp"])
  end

  it "Finds the correct beneficial owner for a chain" do
    expect(@unrelated_company.beneficial_owner_name).to eq("Jeff Bezos")
  end
end
