require 'spec_helper'

describe "documents/index" do
  before(:each) do
    assign(:documents, [
      stub_model(Document,
        :nom => "Nom",
        :chemin => "Chemin",
        :type => "Type",
        :annee => "Annee",
        :mois => "Mois",
        :visibilite => "Visibilite"
      ),
      stub_model(Document,
        :nom => "Nom",
        :chemin => "Chemin",
        :type => "Type",
        :annee => "Annee",
        :mois => "Mois",
        :visibilite => "Visibilite"
      )
    ])
  end

  it "renders a list of documents" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nom".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Chemin".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Annee".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Mois".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Visibilite".to_s, :count => 2
  end
end
