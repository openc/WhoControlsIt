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
    p @control_relationship.parent
  end
end
