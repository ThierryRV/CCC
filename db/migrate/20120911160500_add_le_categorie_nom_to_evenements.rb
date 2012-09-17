class AddLeCategorieNomToEvenements < ActiveRecord::Migration
  def change
    add_column :evenements, :le, :datetime
    add_column :evenements, :categorie, :string
    add_column :evenements, :nom, :string
    add_column :evenements, :genre, :string
  end
end
