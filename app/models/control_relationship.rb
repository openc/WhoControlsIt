class ControlRelationship < ActiveRecord::Base
  belongs_to :child, polymorphic: true
  belongs_to :parent, polymorphic: true

  accepts_nested_attributes_for :child
end
