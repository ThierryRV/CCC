class CreateRelCircuitIndications < ActiveRecord::Migration
  def change
    create_table :rel_circuit_indications do |t|
      t.integer :rang
      t.integer :circuit_id
      t.integer :indication_id

      t.timestamps
    end
  end
end
