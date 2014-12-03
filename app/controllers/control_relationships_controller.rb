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

      document = control_relationship_params.delete(:document)

      company = Company.find_or_create_by(control_relationship_params.delete(:child_attributes))
      params_with_company_id = control_relationship_params.except(:document, :document_cache, :child_attributes).merge(:child_id => company.id, :child_type => 'Company')

      @control_relationship = ControlRelationship.find_or_create_by(params_with_company_id)
      @control_relationship.document = document
      @control_relationship.child = company
    else
      person = Person.find_or_create_by(control_relationship_params.delete(:parent_attributes))
      params_with_person_id = control_relationship_params.except(:parent_attributes).merge(:parent_id => person.id, :parent_type => 'Person')
      # child id and type already submitted
      @control_relationship = ControlRelationship.find_or_create_by(params_with_person_id)
    end

    @control_relationship.save

    if @control_relationship.relationship_type == 'Nominee'
      # We need to say who controls the nominee
      redirect_to new_control_relationship_path(child_id: @control_relationship.parent_id,
                                                child_type: @control_relationship.parent_type)
    else
      redirect_to control_relationship_path(@control_relationship)
    end
  end

  def show
    @control_relationship = ControlRelationship.find(params[:id])
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
                                                 :details,
                                                 :notes,
                                                 :document,
                                                 :document_cache,
                                                 #TODO: why are these different
                                                 :child => ([:id] + company_params + person_params),
                                                 :child_attributes => ([:id] + company_params + person_params),
                                                 #TODO: why are these different
                                                 :parent => ([:id] + company_params + person_params),
                                                 :parent_attributes => ([:id] + company_params + person_params)
                                                )
  end
end
