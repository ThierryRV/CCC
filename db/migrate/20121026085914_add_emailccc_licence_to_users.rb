class AddEmailcccLicenceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :emailccc, :string
    add_column :users, :licence, :string
    add_index :users, :emailccc, unique: true
    add_index :users, :licence, unique: true
  end
end
