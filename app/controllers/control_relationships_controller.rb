class ControlRelationshipsController < ApplicationController
  def new
    @relationship_form = RelationshipForm.new(params.except(:action, :controller, :submit))
    # @control_relationship = ControlRelationship.new
    # if params[:parent_id].present?
    #   @control_relationship.parent = Entity.find(params[:parent_id])
    #   @control_relationship.child = Entity.new
    #   @subject = @control_relationship.parent
    #   @title = "Find a company controlled by #{@control_relationship.parent.name}"
    # elsif params[:child_id].present?
    #   @control_relationship.child = Entity.find(params[:child_id])
    #   @subject = @control_relationship.child
    #   @control_relationship.parent = Entity.new
    #   @title = "Who controls #{@control_relationship.child.name}?"
    # elsif params[:subject_id].present?
    #   @subject = Entity.find(params[:subject_id])
    #   # @control_relationship.child = Entity.find(params[:subject_id])
    #   @control_relationship.parent = Entity.new
    #   @title = "Who controls #{@control_relationship.child.name}?"
    # end
    # @object = Entity.new
  end

  def create
    @relationship_form = RelationshipForm.new(params[:relationship_form])
    if @relationship_form.save
    else
      render :action => 'new'
    end
    # if control_relationship_params[:child_attributes].present?
    #
    #   document = control_relationship_params.delete(:document)
    #
    #   company = Entity.find_or_create_by(control_relationship_params.delete(:child_attributes))
    #   params_with_company_id = control_relationship_params.except(:document, :document_cache, :child_attributes).merge(:child_id => company.id)
    #
    #   @control_relationship = ControlRelationship.find_or_create_by(params_with_company_id)
    #   @control_relationship.document = document
    #   @control_relationship.child = company
    # else
    #   person = Person.find_or_create_by(control_relationship_params.delete(:parent_attributes))
    #   params_with_person_id = control_relationship_params.except(:parent_attributes).merge(:parent_id => person.id)
    #   # child id and type already submitted
    #   @control_relationship = ControlRelationship.find_or_create_by(params_with_person_id)
    # end
    # @control_relationship.save

    if @relationship_form.control_relationship.relationship_type == 'Nominee'
      # We need to say who controls the nominee
      redirect_to new_control_relationship_path(child_id: @relationship_form.control_relationship.parent_id)
    else
      redirect_to control_relationship_path(@relationship_form.control_relationship)
    end
  end

  def show
    @control_relationship = ControlRelationship.find(params[:id])
  end

  private
  def control_relationship_params
    entity_params =[:name, :company_number, :jurisdiction, :date_of_birth, :address, :entity_type]
    company_params = [:company_number, :name, :jurisdiction]
    person_params = [:name, :jurisdiction, :date_of_birth, :address]
    params.require(:control_relationship).permit(:parent_id,
                                                 :child_id,
                                                 :relationship_type,
                                                 :details,
                                                 :notes,
                                                 :document,
                                                 :document_cache,
                                                 #TODO: why are these different
                                                 :child => ([:id]+entity_params),
                                                 :child_attributes => ([:id]+entity_params),
                                                 # :child => ([:id] + company_params + person_params),
                                                 # :child_attributes => ([:id] + company_params + person_params),
                                                 #TODO: why are these different
                                                 # :parent => ([:id] + company_params + person_params),
                                                 # :parent_attributes => ([:id] + company_params + person_params),
                                                 :parent => ([:id] + entity_params),
                                                 :parent_attributes => ([:id] + entity_params)
                                                )
  end
end
