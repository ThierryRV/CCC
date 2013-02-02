class AddSexeToLicences < ActiveRecord::Migration
  def change
    add_column :licences, :sexe, :string
  end
end
