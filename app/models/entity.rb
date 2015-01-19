class Entity < ActiveRecord::Base
  # :child_relationships are ones where the entity is parent, and the relationships are with children
  has_many :child_relationships, :class_name => "ControlRelationship", :foreign_key => "parent_id"
  # ::parent_relationships are ones where the entity is child, and the relationships are with parents
  has_many :parent_relationships, :class_name => "ControlRelationship", :foreign_key => "child_id"
  validates_presence_of :name, :entity_type


  def initialize_graph
    graph = {}
    graph[:nodes] = Set.new
    graph[:edges] = Set.new

    return graph
  end

  def all_relationships
    seen = Set.new

    seen += ControlRelationship.where(["parent_id = ?", self.id])
    seen += ControlRelationship.where(["child_id = ?", self.id])

    while true
      prev_seen_length = seen.length
      seen.each {|r|
        seen += ControlRelationship.where(["parent_id = ?", r.parent_id])
        seen += ControlRelationship.where(["child_id = ?", r.child_id])
        seen += ControlRelationship.where(["parent_id = ?", r.child_id])
        seen += ControlRelationship.where(["child_id = ?", r.parent_id])
      }
      break if seen.length == prev_seen_length
    end

    seen
  end

  def opencorporates_url
    return unless jurisdiction.to_s[/^\w\w(_\w\w)?$/] && company_number
    "https://OpenCorporates.com/companies/#{jurisdiction}/#{company_number}"
  end

  def parent_control_relationships
    seen = Set.new

    seen += ControlRelationship.where(["child_id = ?", self.id])

    while true
      prev_seen_length = seen.length
      #TODO: something isn't quite right here
      2.times do
        seen.each {|r|
          seen += ControlRelationship.where(:child => r.parent)
        }
      end
      break if seen.length == prev_seen_length
    end

    seen
  end

  def graph_relationships
    graph = initialize_graph

    all_relationships.each do |r|
      graph[:nodes] << make_node(r.parent)
      graph[:nodes] << make_node(r.child)
      graph[:edges] << make_edge(r.parent, r.child, r.details)
    end

    # Add x and y positions after, otherwise the rand will
    # mess up the Set uniqueness
    graph[:nodes] = graph[:nodes].to_a.map {|n|
      n.merge({
        x: rand(10).to_s,
        y: rand(10).to_s
      })
    }

    return graph
  end

  def make_node(obj)
    {
      data: {
        id: "#{obj.id}",
        label: obj.name,
        color: ((obj.entity_type.to_s == 'Person') ? 'rgb(125,125,255)' : 'rgb(255,125,125)'),
        type: obj.entity_type.to_s
      }
    }
  end

  def make_edge(source, target, details)
    {
      data: {
        id: "#{source.name}-#{target.name}",
        label: "controls",
        source:  "#{source.id}",
        target:  "#{target.id}",
        percentage: Float(details[0..-2])  # Remove the trailing % and convert to number
      }
    }
  end

end
