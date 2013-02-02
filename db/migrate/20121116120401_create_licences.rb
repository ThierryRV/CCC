class CreateLicences < ActiveRecord::Migration
  def change
    create_table :licences do |t|
      t.string :numero
      t.string :nom
      t.string :prenom
      t.string :reference
      t.string :adresse
      t.string :code_postal
      t.string :ville
      t.string :telephone
      t.date :naissance
      t.string :email
      t.date :inscription

      t.timestamps
    end
  end
end
