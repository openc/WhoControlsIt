class CompaniesController < ApplicationController
  autocomplete :company, :name

  def index
    if params[:name]
      @companies = Company.where(:name => params[:name]).page(params[:page])
    else
      @companies = Company.order('created_at DESC').page(params[:page])
    end
  end

  def show
    @company = Company.find(params[:id])
  end
end
