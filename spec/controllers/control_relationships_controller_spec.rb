require 'rails_helper'

RSpec.describe ControlRelationshipsController, :type => :controller do
  before do
    @entity = FactoryGirl.create(:company_entity)
  end

  context 'get NEW' do
    describe 'when passed id of parent_entity' do
      before do
        get :new, :parent_id => @entity.id
      end

      it "should return success" do
        response.should be_success
      end

      it "should render show template" do
        response.should render_template(:new)
      end

      it 'should return html' do
        response.content_type.should == "text/html"
      end

      it 'should assign control_relationship' do
        assigns[:control_relationship].should be_kind_of ControlRelationship
      end

      it 'should assign parent_entity to control_relationship' do
        assigns[:control_relationship].parent.should == @entity
      end
    end

  end

  context 'post CREATE' do
    before do
      @old_count = ControlRelationship.count

      control_relationship_params =
      { "details"=>"90",
        "relationship_type"=>"Shareholding",
        "parent_id"=>@entity.id,
        "child_attributes"=>
          { "name"=>"CHRINON LTD",
            "company_number"=>"07444723",
            "jurisdiction"=>"gb",
            "entity_type" => 'Company'},
        "notes"=>"something goes here"}

      post :create, :control_relationship => control_relationship_params
    end

    it 'should create a control_relationship' do
      ControlRelationship.count.should == @old_count + 1
      ControlRelationship.last
    end

    # it "should redirect" do
    #   response.should be_redirect
    # end

    it 'should return html' do
      response.content_type.should == "text/html"
    end

    it 'should create entity with given params' do
      assigns[:control_relationship].relationship_type.should == "Shareholding"
      assigns[:control_relationship].parent.should == @entity
      assigns[:control_relationship].details.should == "90"
      assigns[:control_relationship].new_record?.should == false
    end

  end
end
