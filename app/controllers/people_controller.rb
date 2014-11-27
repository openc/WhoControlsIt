class PeopleController < ApplicationController
  def new
    @person = Person.new  
  end

  def show
    @person = Person.find(params[:id])
    @child_relationships = @person.child_relationships
    @graph = {}
    @graph[:nodes] = []
    @graph[:edges] = []

    @graph[:nodes] << make_node(@person)

    @child_relationships.each do |r|
      @graph[:nodes] << make_node(r.child)
      @graph[:edges] << make_edge(@person, r.child)
      r.child.child_relationships.each do |c|
        @graph[:nodes] << make_node(c.child)
        @graph[:edges] << make_edge(r.child, c.child)
      end 
    end
  end

  def graph_relationships
    @person = Person.find(params[:id])
    @child_relationships = @person.child_relationships
    @graph = {}
    @graph[:nodes] = []
    @graph[:edges] = []

    @graph[:nodes] << make_node(@person)

    @child_relationships.each do |r|
      @graph[:nodes] << make_node(r.child)
      @graph[:edges] << make_edge(@person, r.child)
      r.child.child_relationships.each do |c|
        @graph[:nodes] << make_node(c.child)
        @graph[:edges] << make_edge(r.child, c.child)
      end 
    end

    render :json => @graph
  end

  def create
    @person = Person.find_or_create_by(person_params)

    redirect_to new_control_relationship_path(parent_id: @person, parent_type: 'Person')
  end

  private
  def make_node(obj)
    {
      id: "#{obj.class}-#{obj.id}",
      label: obj.name,
      size: 5,
      color: ((obj.class.to_s == 'Person') ? 'rgb(125,125,255)' : 'rgb(255,125,125)'),
      type: obj.class.to_s,
      x: rand(10).to_s,
      y: rand(10).to_s
    }
  end

  def make_edge(source, target)
    {
      id: "#{source.name}-#{target.name}",
      label: "controls",
      source:  "#{source.class}-#{source.id}",
      target:  "#{target.class}-#{target.id}"
    }
  end

  def person_params
    params.require(:person).permit(:name, :nationality, :date_of_birth, :address)
  end
end
