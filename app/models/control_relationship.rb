class ControlRelationship < ActiveRecord::Base
  belongs_to :company
  belongs_to :person

  accepts_nested_attributes_for :company
end
