class Licence < ActiveRecord::Base
  attr_accessible :adresse, :code_postal, :email, :inscription, :naissance, :nom, :numero, :prenom, :reference, :telephone, :ville
end
# == Schema Information
#
# Table name: licences
#
#  id          :integer(4)      not null, primary key
#  numero      :string(255)
#  nom         :string(255)
#  prenom      :string(255)
#  reference   :string(255)
#  adresse     :string(255)
#  code_postal :string(255)
#  ville       :string(255)
#  telephone   :string(255)
#  naissance   :date
#  email       :string(255)
#  inscription :date
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  sexe        :string(255)
#

