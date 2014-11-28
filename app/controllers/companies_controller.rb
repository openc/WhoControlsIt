class CompaniesController < ApplicationController
  autocomplete :company, :name

  def index
    if params[:name]
      @companies = Company.where(:name => params[:name]).page(params[:page])
    else
      @companies = Company.order('created_at DESC').page(params[:page])
    end
  end

  def graph_relationships
    @company = Company.find(params[:id])
    @graph = @company.graph_relationships

    render :json => @graph
  end

  def show
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.find_or_create_by(company_params)
    @company.save
    # We're assuming one workflow for creating companies for now
    redirect_to new_control_relationship_path(child_id: @company.id, child_type: @company.class.to_s)
  end

  private
  def company_params
    params.require(:company).permit(:name, :company_number, :jurisdiction_code)
  end
end
