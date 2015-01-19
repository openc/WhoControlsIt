require 'carrierwave/orm/activerecord'

class ControlRelationship < ActiveRecord::Base
  POSSIBLE_RELATIONSHIP_TYPES = {
    'Shareholding' => ['percentage_owned', 'share_class', 'number_of_shares'],
    'VotingRights' => ['percentage'],
    'Nominee' => [],
    'TrustBeneficiary' => [],
    'MajorityOfDirectors' => ['names_of_directors'],
    'OtherRelationship' => ['description_of_relationship']
  }
  belongs_to :child, :class_name => 'Entity'
  belongs_to :parent, :class_name => 'Entity'

  accepts_nested_attributes_for :child
  accepts_nested_attributes_for :parent
  serialize :details

  validates_presence_of :parent_id, :child_id
  validates_inclusion_of :relationship_type, :in => POSSIBLE_RELATIONSHIP_TYPES.keys

  mount_uploader :document, DocumentUploader

  attr_accessor :subject_id, :subject, :object_id, :object, :subject_type

  def self.create_from_form_params(form_params)
    subject_type = form_params.delete(:subject_type)
    if subject_type == 'parent'
      child = find_or_create_entity(form_params.delete(:object_attributes))
      parent = find_or_create_entity(form_params.delete(:subject_id))
    else
      parent = find_or_create_entity(form_params.delete(:object_attributes))
      child = find_or_create_entity(form_params.delete(:subject_id))
    end
    cr = create!(form_params.merge(:child => child, :parent => parent))
  end


  private
  def self.find_or_create_entity(attribs_or_id)
    if attribs_or_id.is_a?(Hash)
      Entity.create(attribs_or_id)
    else
      Entity.find(attribs_or_id)
    end
  end
end
