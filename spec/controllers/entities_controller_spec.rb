require 'rails_helper'

RSpec.describe EntitiesController, :type => :controller do
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

end
