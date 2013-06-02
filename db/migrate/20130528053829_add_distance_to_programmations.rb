class AddDistanceToProgrammations < ActiveRecord::Migration
  def change
    add_column :programmations, :distance, :integer
  end
end
