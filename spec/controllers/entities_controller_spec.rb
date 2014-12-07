require 'rails_helper'

RSpec.describe EntitiesController, :type => :controller do

  describe 'when entity show view requested' do
    before do
      @entity = FactoryGirl.create(:company_entity)
    end

    describe 'and entity does exist' do
      before do
        get :show, :id => @entity.id
      end

      it "should return success" do
        response.should be_success
      end

      it "should render show template" do
        response.should render_template(:show)
      end

      it 'should return html' do
        response.content_type.should == "text/html"
      end

      it 'should assign entity' do
        assigns[:entity].should == @entity
      end
    end

  end


  describe 'when entity new action requested' do
    context 'and company type requested' do
      before do
        get :new, :entity => {:entity_type => 'Company'}
      end

      it "should return success" do
        response.should be_success
      end

      it "should render show template" do
        response.should render_template(:new_company)
      end

      it 'should return html' do
        response.content_type.should == "text/html"
      end

      it 'should assign entity' do
        assigns[:entity].should be_kind_of Entity
        assigns[:entity].entity_type.should == 'Company'
      end

    end

    context 'and person type requested' do
      before do
        get :new, :entity => {:entity_type => 'Person'}
      end

      it "should return success" do
        response.should be_success
      end

      it "should render show template" do
        response.should render_template(:new_person)
      end

      it 'should return html' do
        response.content_type.should == "text/html"
      end

      it 'should assign entity type' do
        assigns[:entity].should be_kind_of Entity
        assigns[:entity].entity_type.should == 'Person'
      end

    end
  end

  describe 'when entity is created' do
    before do
      post :create, :entity => {:name => "New Entity", :entity_type => 'Company', :jurisdiction => 'France'}
    end

    it "should redirect to new control relationship" do
      @new_entity = Entity.last
      response.should redirect_to new_control_relationship_path(parent_id: @new_entity.id)
    end

    it 'should return html' do
      response.content_type.should == "text/html"
    end

    it 'should create entity with given params' do
      assigns[:entity].name.should == "New Entity"
      assigns[:entity].entity_type.should == "Company"
      assigns[:entity].jurisdiction.should == "France"
      assigns[:entity].new_record?.should == false
    end

  end


end
