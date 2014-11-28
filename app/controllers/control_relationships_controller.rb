class ControlRelationshipsController < ApplicationController
  def new
    @control_relationship = ControlRelationship.new
    if params[:parent_id].present?
      @parent = params[:parent_type].constantize.find(params[:parent_id])
      @child = Company.new
      @title = "Find a company I control"
      render :new_for_parent_person
    elsif params[:child_id].present?
      @person = Person.new
      @child = params[:child_type].constantize.find(params[:child_id])
      @title = "Who controls #{@child.name}?"
      render :new_for_child_company
    end
  end

  def create
    if control_relationship_params[:child_attributes].present?
      company = Company.find_or_create_by(control_relationship_params.delete(:child_attributes))
      params_with_company_id = control_relationship_params.except(:child_attributes).merge(:child_id => company.id, :child_type => 'Company')
      @control_relationship = ControlRelationship.find_or_create_by(params_with_company_id)
      @control_relationship.child = company
    else
      person = Person.find_or_create_by(control_relationship_params.delete(:parent))
      params_with_person_id = control_relationship_params.except(:parent).merge(:parent_id => person.id, :parent_type => 'Person')
      # child id and type already submitted
      @control_relationship = ControlRelationship.find_or_create_by(params_with_person_id)
    end

    @control_relationship.save
  end

  private
  def control_relationship_params
    company_params = [:company_number, :name, :jurisdiction_code]
    person_params = [:name, :nationality, :date_of_birth, :address]
    params.require(:control_relationship).permit(:parent_id, 
                                                 :parent_type,
                                                 :child_id,
                                                 :child_type,
                                                 :relationship_type,
                                                 :child_attributes => ([:id] + company_params + person_params),
                                                 :parent => ([:id] + company_params + person_params)
                                                )
  end
end
