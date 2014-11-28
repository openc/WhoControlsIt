class CompaniesController < ApplicationController
  def index
    @companies = Company.order('created_at DESC').page(params[:page])
  end

  def show
    @company = Company.find(params[:id])
  end
end
