class AddIdOpenrunnerToCircuits < ActiveRecord::Migration
  def change
    add_column :circuits, :id_openrunner, :string
  end
end
