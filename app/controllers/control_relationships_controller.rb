class ControlRelationshipsController < ApplicationController
  def create
    company = Company.find_or_create_by(control_relationship_params.delete(:company))
    params_with_company_id = control_relationship_params.except(:company).merge(:company_id => company.id)
    @control_relationship = ControlRelationship.find_or_create_by(params_with_company_id)
    @control_relationship.company = company
    @control_relationship.save
  end

  private
  def control_relationship_params
    params.require(:control_relationship).permit(:person_id, :relationship_type, :company => [:id, :company_number, :name, :jurisdiction_code])
  end
end
