class CreateProgrammations < ActiveRecord::Migration
  def change
    create_table :programmations do |t|
      t.string :groupe
      t.datetime :le
      t.references :programme, :polymorphic => true

      t.timestamps
    end
  end
end
