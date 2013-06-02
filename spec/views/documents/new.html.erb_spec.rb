require 'spec_helper'

describe "documents/new" do
  before(:each) do
    assign(:document, stub_model(Document,
      :nom => "MyString",
      :chemin => "MyString",
      :type => "",
      :annee => "MyString",
      :mois => "MyString",
      :visibilite => "MyString"
    ).as_new_record)
  end

  it "renders new document form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => documents_path, :method => "post" do
      assert_select "input#document_nom", :name => "document[nom]"
      assert_select "input#document_chemin", :name => "document[chemin]"
      assert_select "input#document_type", :name => "document[type]"
      assert_select "input#document_annee", :name => "document[annee]"
      assert_select "input#document_mois", :name => "document[mois]"
      assert_select "input#document_visibilite", :name => "document[visibilite]"
    end
  end
end
