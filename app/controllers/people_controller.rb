class PeopleController < ApplicationController
  def new
    @person = Person.new  
  end

  def create
    @person = Person.find_or_create_by(person_params)

    redirect_to new_control_relationship_path(parent_id: @person, parent_type: 'Person')
  end

  private

  def person_params
    params.require(:person).permit(:name, :nationality, :date_of_birth, :address)
  end
end
