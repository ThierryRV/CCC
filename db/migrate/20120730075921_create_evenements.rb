class CreateEvenements < ActiveRecord::Migration
  def change
    create_table :evenements do |t|
      t.string :description

      t.timestamps
    end
  end
end
