class Person < ActiveRecord::Base
  has_many :child_relationships, as: :parent, class_name: 'ControlRelationship'
  has_many :parent_relationships, as: :child, class_name: 'ControlRelationship'
end
