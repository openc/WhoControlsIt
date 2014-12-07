class EntitiesController < ApplicationController

  def create
    @entity = Entity.find_or_create_by(entity_params)
    @entity.save
    # We're assuming one workflow for creating companies for now
    # redirect_to new_control_relationship_path(child_id: @company.id, child_type: @company.class.to_s)
    redirect_to new_control_relationship_path(parent_id: @entity.id)
  end

  def new
    @entity = Entity.new(entity_params)
    template = "entities/new_#{@entity.entity_type.downcase}"
    render :template => template
  end

  def show
    @entity = Entity.find(params[:id])
  end

  private
  def entity_params
    params.require(:entity).permit(:entity_type, :name, :jurisdiction, :company_number, :date_of_birth, :address)
  end
end
