require 'rails_helper'

RSpec.describe ControlRelationship, :type => :model do
  before do
    @control_relationship = FactoryGirl.create(:control_relationship)
  end

  it 'should have child entity' do
    @control_relationship.child.should be_kind_of Entity
  end

  it 'should have parent entity' do
    @control_relationship.parent.should be_kind_of Entity
  end

  it 'should serialize details field' do
    @control_relationship.details = {:foo => 'bar'}
    @control_relationship.save!
    @control_relationship.reload.details.should == {:foo => 'bar'}
  end

  describe 'create_from_form_params' do
    before do
      @entity = FactoryGirl.create(:company_entity)
    end

    context 'when object is not created' do
      before do
        @control_rel_params = {
          :subject_id=>@entity.id,
          :subject_type => 'parent',
          :relationship_type=>"Shareholding",
          :details=>{:percentage_held => "80"},
          :notes=>"Some notes here",
          :object_attributes=>{
            :name=>"BOBBY FAST FOOD SRL",
            :company_number=>"30865802",
            :jurisdiction=>"ro",
            :entity_type=>"Company"}}
        @old_count = ControlRelationship.count
        ControlRelationship.create_from_form_params(@control_rel_params)
      end

      it 'should create control relationship' do
        ControlRelationship.count.should == @old_count + 1
        newly_added = ControlRelationship.last
        newly_added.relationship_type.should == "Shareholding"
        newly_added.notes.should == "Some notes here"
        newly_added.details.should == {:percentage_held => "80"}
      end

      it 'should associate with entities' do
        parent = ControlRelationship.last.parent
        parent.should == @entity
        child = ControlRelationship.last.child
        child.should be_kind_of Entity
        child.name.should == 'BOBBY FAST FOOD SRL'
        child.company_number.should == "30865802"
      end
    end

    context 'when subject_type is child' do
      before do
        @control_rel_params = {
          :subject_id=>@entity.id,
          :subject_type => 'child',
          :relationship_type=>"Shareholding",
          :details=>{:percentage_held => "80"},
          :notes=>"Some notes here",
          :object_attributes=>{
            :name=>"BOBBY FAST FOOD SRL",
            :company_number=>"30865802",
            :jurisdiction=>"ro",
            :entity_type=>"Company"}}
        @old_count = ControlRelationship.count
        ControlRelationship.create_from_form_params(@control_rel_params)
      end

      it 'should create control relationship' do
        ControlRelationship.count.should == @old_count + 1
        newly_added = ControlRelationship.last
        newly_added.relationship_type.should == "Shareholding"
        newly_added.notes.should == "Some notes here"
        newly_added.details.should == {:percentage_held => "80"}
      end

      it 'should associate with entities' do
        child = ControlRelationship.last.child
        child.should == @entity
        parent = ControlRelationship.last.parent
        parent.should be_kind_of Entity
        parent.name.should == 'BOBBY FAST FOOD SRL'
        parent.company_number.should == "30865802"
      end
    end
  end
end
