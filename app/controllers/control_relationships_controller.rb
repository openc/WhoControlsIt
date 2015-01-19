class ControlRelationshipsController < ApplicationController
  def new
    @relationship_form = RelationshipForm.new(params.except(:action, :controller, :submit))
  end

  def create
    @relationship_form = RelationshipForm.new(params[:relationship_form])
    if @relationship_form.save
    else
      render :action => 'new'
    end

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
  # def control_relationship_params
  #   entity_params =[:name, :company_number, :jurisdiction, :date_of_birth, :address, :entity_type]
  #   company_params = [:company_number, :name, :jurisdiction]
  #   person_params = [:name, :jurisdiction, :date_of_birth, :address]
  #   params.require(:control_relationship).permit(:parent_id,
  #                                                :child_id,
  #                                                :relationship_type,
  #                                                :details,
  #                                                :notes,
  #                                                :document,
  #                                                :document_cache,
  #                                                #TODO: why are these different
  #                                                :child => ([:id]+entity_params),
  #                                                :child_attributes => ([:id]+entity_params),
  #                                                # :child => ([:id] + company_params + person_params),
  #                                                # :child_attributes => ([:id] + company_params + person_params),
  #                                                #TODO: why are these different
  #                                                # :parent => ([:id] + company_params + person_params),
  #                                                # :parent_attributes => ([:id] + company_params + person_params),
  #                                                :parent => ([:id] + entity_params),
  #                                                :parent_attributes => ([:id] + entity_params)
  #                                               )
  # end
end
