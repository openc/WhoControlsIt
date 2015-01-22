class EntitiesController < ApplicationController
  autocomplete :entity, :name

  def create
    @entity = Entity.create(entity_params)
    subject_type = params[:subject_type]
    set_user_if_applicable
    # We're assuming one workflow for creating companies for now
    # redirect_to new_control_relationship_path(child_id: @company.id, child_type: @company.class.to_s)
    subject_type = params[:subject_type] || 'parent'
    redirect_to new_control_relationship_path(:subject_id => @entity.id, :subject_type => subject_type)
  end

  def graph_relationships
    @entity = Entity.find(params[:id])
    # @child_relationships = @entity.child_relationships
    @graph = @entity.graph_relationships

    render :json => @graph
  end

  def index
    if params[:name]
      @entities = Entity.where(:name => params[:name]).page(params[:page])
    else
      @entities = Entity.order('created_at DESC').page(params[:page])
    end
  end

  def new
    @entity = Entity.new(entity_params)
    template = "entities/new_#{@entity.entity_type.downcase}"
    render :template => template
  end

  def show
    @entity = Entity.find(params[:id])
    @child_relationships = @entity.child_relationships
  end

  private
  def entity_params
    params.require(:entity).permit(:entity_type, :name, :jurisdiction, :company_number, :date_of_birth, :address)
  end

  def set_user_if_applicable
    if !@entity.new_record? and
      @entity.entity_type == 'Person' and
        (params[:subject_type].nil? or params[:subject_type] == 'parent')
      session[:current_user_id] = @entity.id
    end
  end
end
