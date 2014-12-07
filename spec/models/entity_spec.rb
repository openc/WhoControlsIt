require 'rails_helper'

RSpec.describe Entity, :type => :model do
  before do
    @company_entity = FactoryGirl.create(:company_entity)
  end

  it 'should not be valid without a name' do
    entity = Entity.new
    entity.should_not be_valid
    entity.errors[:name].should == ["can't be blank"]
  end

  it 'should not be valid without entity_type' do
    entity = Entity.new
    entity.should_not be_valid
    entity.errors[:entity_type].should == ["can't be blank"]
  end

  it 'should have many child_relationships' do
    cr = FactoryGirl.create(:control_relationship,
                            :parent => @company_entity)
    @company_entity.child_relationships.should == [cr]
  end

  it 'should have many parent_relationships' do
    cr = FactoryGirl.create(:control_relationship,
                            :child => @company_entity)
    @company_entity.parent_relationships.should == [cr]
  end

end
