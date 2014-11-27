class ControlRelationship < ActiveRecord::Base
  belongs_to :child, polymorphic: true
  belongs_to :parent, polymorphic: true

  accepts_nested_attributes_for :child

  validates_presence_of :parent_id, :parent_type, :child_id, :child_type
end
