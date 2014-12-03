module Graphable
  extend ActiveSupport::Concern

  included do
    has_many :child_relationships, as: :parent, class_name: 'ControlRelationship'
    has_many :parent_relationships, as: :child, class_name: 'ControlRelationship'
  end

  def initialize_graph
    graph = {}
    graph[:nodes] = Set.new
    graph[:edges] = Set.new

    return graph
  end

  def all_relationships
    seen = Set.new

    seen += ControlRelationship.where(["parent_id = ? and parent_type = ?", self.id, self.class.to_s])
    seen += ControlRelationship.where(["child_id = ? and child_type = ?", self.id, self.class.to_s])

    while true
      prev_seen_length = seen.length
      seen.each {|r|
        seen += ControlRelationship.where(["parent_id = ? and parent_type = ?", r.parent_id, r.parent_type])
        seen += ControlRelationship.where(["child_id = ? and child_type = ?", r.child_id, r.child_type])
        seen += ControlRelationship.where(["parent_id = ? and parent_type = ?", r.child_id, r.child_type])
        seen += ControlRelationship.where(["child_id = ? and child_type = ?", r.parent_id, r.parent_type])
      }
      break if seen.length == prev_seen_length
    end

    seen
  end

  def graph_relationships
    graph = initialize_graph

    all_relationships.each do |r|
      graph[:nodes] << make_node(r.parent)
      graph[:nodes] << make_node(r.child)
      graph[:edges] << make_edge(r.parent, r.child)
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
      id: "#{obj.class}-#{obj.id}",
      label: obj.name,
      size: 5,
      color: ((obj.class.to_s == 'Person') ? 'rgb(125,125,255)' : 'rgb(255,125,125)'),
      type: obj.class.to_s
    }
  end

  def make_edge(source, target)
    {
      id: "#{source.name}-#{target.name}",
      label: "controls",
      source:  "#{source.class}-#{source.id}",
      target:  "#{target.class}-#{target.id}"
    }
  end
end
