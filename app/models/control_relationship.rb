require 'carrierwave/orm/activerecord'

class ControlRelationship < ActiveRecord::Base
  belongs_to :child, :class_name => 'Entity'
  belongs_to :parent, :class_name => 'Entity'

  accepts_nested_attributes_for :child
  accepts_nested_attributes_for :parent

  validates_presence_of :parent_id, :child_id

  mount_uploader :document, DocumentUploader
end
