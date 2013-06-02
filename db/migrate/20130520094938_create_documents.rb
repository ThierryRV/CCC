class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :nom
      t.string :chemin
      t.string :type_doc
      t.string :annee
      t.string :mois
      t.string :visibilite

      t.timestamps
    end
  end
end
