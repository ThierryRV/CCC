class AddParticulariteToEvenements < ActiveRecord::Migration
  def change
    add_column :evenements, :particularite, :string
  end
end
