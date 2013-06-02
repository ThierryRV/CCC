require 'spec_helper'

describe "documents/show" do
  before(:each) do
    @document = assign(:document, stub_model(Document,
      :nom => "Nom",
      :chemin => "Chemin",
      :type => "Type",
      :annee => "Annee",
      :mois => "Mois",
      :visibilite => "Visibilite"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nom/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Chemin/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Annee/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Mois/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Visibilite/)
  end
end
