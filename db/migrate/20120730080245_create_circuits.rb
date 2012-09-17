class CreateCircuits < ActiveRecord::Migration
  def change
    create_table :circuits do |t|
      t.string :description
      t.string :direction
      t.integer :longueur
      t.string :difficulte
      t.integer :denivele

      t.timestamps
    end
  end
end
