class PeopleController < ApplicationController
  def new
    @person = Person.new  
  end

  def create
    @person = Person.find_or_create_by(person_params)
  end

  private

  def person_params
    params.require(:person).permit(:name, :nationality, :date_of_birth, :address)
  end
end
