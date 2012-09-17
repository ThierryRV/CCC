class CreateIndications < ActiveRecord::Migration
  def change
    create_table :indications do |t|
      t.string :nom

      t.timestamps
    end
  end
end
