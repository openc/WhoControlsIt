class Entity < ActiveRecord::Base
  # :child_relationships are ones where the entity is parent, and the relationships are with children
  has_many :child_relationships, :class_name => "ControlRelationship", :foreign_key => "parent_id"
  # ::parent_relationships are ones where the entity is child, and the relationships are with parents
  has_many :parent_relationships, :class_name => "ControlRelationship", :foreign_key => "child_id"
  validates_presence_of :name, :entity_type
end
