class AddObservationsToProgrammations < ActiveRecord::Migration
  def change
    add_column :programmations, :observations, :string
  end
end
