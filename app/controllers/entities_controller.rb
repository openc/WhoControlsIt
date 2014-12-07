class EntitiesController < ApplicationController
  def new
    @entity = Entity.new(entity_params)
    template = "entities/new_#{@entity.entity_type.downcase}"
    render :template => template
  end

  private
  def entity_params
    params.require(:entity).permit(:entity_type)
  end
end
