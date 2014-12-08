class RelationshipForm
  include ActiveModel::Model

  extend CarrierWave::Mount
  attr_accessor :subject_attributes, :subject_id, :object_attributes, :object_id, :subject_type, :relationship_type, :details, :notes, :document, :control_relationship

  validates_presence_of :relationship_type

  mount_uploader :document, DocumentUploader

  def subject
    @subject || (subject_id && Entity.find(subject_id)) || Entity.new
  end

  def object
    @object || (object_id && Entity.find(object_id)) || Entity.new
  end

  def predicate
    subject[:type] == 'parent' ? 'controls' : 'is controlled by'
  end

  def save
    return false unless valid?
    subject_obj = find_or_create(subject_id, subject_attributes)
    object_obj = find_or_create(object_id, object_attributes)
    child, parent = subject_type == 'child' ? [subject_obj,object_obj] : [object_obj,subject_obj]

    @control_relationship = ControlRelationship.create(:child => child, :parent => parent, :details => details, :notes => notes, :relationship_type => relationship_type)
  end


  def find_or_create(entity_id, entity_attribs)
    entity_id ? Entity.find(entity_id) : Entity.create(entity_attribs)
  end

end