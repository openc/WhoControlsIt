class CompaniesController < ApplicationController
  def index
    @companies = Company.order('created_at DESC').page(params[:page])
  end
end
