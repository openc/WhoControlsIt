require 'rails_helper'

RSpec.describe ControlRelationshipsController, :type => :controller do
  before do
    @entity = FactoryGirl.create(:company_entity)
  end

  # context 'get NEW' do
  #   describe 'when passed id of parent_entity' do
  #     before do
  #       get :new, :parent_id => @entity.id
  #     end
  #
  #     it "should return success" do
  #       response.should be_success
  #     end
  #
  #     it "should render show template" do
  #       response.should render_template(:new)
  #     end
  #
  #     it 'should return html' do
  #       response.content_type.should == "text/html"
  #     end
  #
  #     it 'should assign control_relationship' do
  #       assigns[:control_relationship].should be_kind_of ControlRelationship
  #     end
  #
  #     it 'should assign parent_entity to control_relationship' do
  #       assigns[:control_relationship].parent.should == @entity
  #     end
  #   end
  #
  #   describe 'when passed id of child_entity' do
  #     before do
  #       get :new, :child_id => @entity.id
  #     end
  #
  #     it "should return success" do
  #       response.should be_success
  #     end
  #
  #     it "should render show template" do
  #       response.should render_template(:new)
  #     end
  #
  #     it 'should return html' do
  #       response.content_type.should == "text/html"
  #     end
  #
  #     it 'should assign control_relationship' do
  #       assigns[:control_relationship].should be_kind_of ControlRelationship
  #     end
  #
  #     it 'should assign parent_entity to control_relationship' do
  #       assigns[:control_relationship].child.should == @entity
  #     end
  #   end
  #
  #   describe 'when passed id of subject with subject_type' do
  #     before do
  #       get :new, :subject_id => @entity.id, :subject_type => 'child'
  #     end
  #
  #     it "should return success" do
  #       response.should be_success
  #     end
  #
  #     it "should render show template" do
  #       response.should render_template(:new)
  #     end
  #
  #     it 'should return html' do
  #       response.content_type.should == "text/html"
  #     end
  #
  #     it 'should assign control_relationship' do
  #       assigns[:control_relationship].should be_kind_of ControlRelationship
  #     end
  #
  #     it 'should assign entity to control_relationship as child' do
  #       assigns[:control_relationship].child.should == @entity
  #     end
  #   end
  # end
  #
  context 'post CREATE' do
    before do
      @old_count = ControlRelationship.count
      @old_entity_count = Entity.count

      # @control_rel_params = {
      #   :subject_id=>@entity.id,
      #   :subject_type => 'parent',
      #   :relationship_type=>"Shareholding",
      #   :details=>{:percentage_owned => "80"},
      #   :notes=>"Some notes here",
      #   :object_attributes=>{
      #     :name=>"BOBBY FAST FOOD SRL",
      #     :company_number=>"30865802",
      #     :jurisdiction=>"ro",
      #     :entity_type=>"Company"}}

      control_relationship_params =
      { "details"=>{'percentage_owned' => "90"},
        "relationship_type"=>"Shareholding",
        "subject_id" => @entity.id,
        "subject_type" => 'parent',
        "object_attributes"=>
          { "name"=>"CHRINON LTD",
            "company_number"=>"07444723",
            "jurisdiction"=>"gb",
            "entity_type" => 'Company'},
        "notes"=>"something goes here"}

      post :create, :relationship_form => control_relationship_params
    end

    it 'should return html' do
      response.content_type.should == "text/html"
    end

    it 'should create relationship with given params' do
      ControlRelationship.count.should == @old_count + 1
      relationship = ControlRelationship.last
      relationship.relationship_type.should == "Shareholding"
      relationship.details.should == {'percentage_owned' => "90"}
    end

    it 'should create entity with given params' do
      Entity.count.should == @old_entity_count + 1
      entity = Entity.last
      entity.name.should == "CHRINON LTD"
    end

  end
end
