module Graphable
  extend ActiveSupport::Concern

  included do
    has_many :child_relationships, as: :parent, class_name: 'ControlRelationship'
    has_many :parent_relationships, as: :child, class_name: 'ControlRelationship'
  end

  def graph_relationships
    # This isn't working yet. Graph needs to recurse both ways for each node
    graph = initialize_graph

    parent_nodes, parent_edges = get_parent_relationships_for_node(self).values_at(:nodes, :edges)
    child_nodes, child_edges = get_child_relationships_for_node(self).values_at(:nodes, :edges)

    graph[:nodes] = parent_nodes + child_nodes
    graph[:edges] = parent_edges + child_edges
    graph[:nodes] << make_node(self)

    return graph
  end

  def initialize_graph
    graph = {}
    graph[:nodes] = Set.new
    graph[:edges] = Set.new

    return graph
  end

  def get_child_relationships_for_node(node, graph = initialize_graph)
    if node.child_relationships.empty?
      return graph
    else
      node.child_relationships.each do |r|
        graph[:nodes] << make_node(r.child)
        graph[:edges] << make_edge(node, r.child)
        return get_child_relationships_for_node(r.child, graph)
      end
    end
  end

  def get_parent_relationships_for_node(node, graph = initialize_graph)
    if node.parent_relationships.empty?
      return graph
    else
      node.parent_relationships.each do |r|
        graph[:nodes] << make_node(r.parent)
        graph[:edges] << make_edge(r.parent, node)
        return get_parent_relationships_for_node(r.parent, graph)
      end
    end
  end

  def make_node(obj)
    {
      id: "#{obj.class}-#{obj.id}",
      label: obj.name,
      size: 5,
      color: ((obj.class.to_s == 'Person') ? 'rgb(125,125,255)' : 'rgb(255,125,125)'),
      type: obj.class.to_s,
      x: rand(10).to_s,
      y: rand(10).to_s
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
