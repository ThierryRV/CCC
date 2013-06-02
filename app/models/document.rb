# == Schema Information
#
# Table name: documents
#
#  id         :integer(4)      not null, primary key
#  nom        :string(255)
#  chemin     :string(255)
#  type_doc   :string(255)
#  annee      :string(255)
#  mois       :string(255)
#  visibilite :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Document < ActiveRecord::Base
  attr_accessible :annee, :chemin, :mois, :nom, :type_doc, :visibilite

  scope :filtre_type_doc, lambda { |type_doc| where("type_doc like ?", '%' + type_doc + '%') }
  scope :filtre_annee, lambda { |annee_min, annee_max| where("annee >= ? and annee <=?", annee_min,annee_max) }

end
