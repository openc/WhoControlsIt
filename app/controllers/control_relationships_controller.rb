class ControlRelationshipsController < ApplicationController
  def new
    @control_relationship = ControlRelationship.new
    @parent = params[:parent_type].constantize.find(params[:parent_id])
    @child = Company.new
  end

  def create
    company = Company.find_or_create_by(control_relationship_params.delete(:child_attributes))
    params_with_company_id = control_relationship_params.except(:child_attributes).merge(:child_id => company.id, :child_type => 'Company')
    @control_relationship = ControlRelationship.find_or_create_by(params_with_company_id)
    @control_relationship.child = company
    @control_relationship.save
  end

  private
  def control_relationship_params
    params.require(:control_relationship).permit(:parent_id, :parent_type, :child_id, :child_type, :relationship_type, :child_attributes => [:id, :company_number, :name, :jurisdiction_code])
  end
end
