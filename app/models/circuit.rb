# == Schema Information
#
# Table name: circuits
#
#  id            :integer(4)      not null, primary key
#  description   :string(255)
#  direction     :string(255)
#  longueur      :integer(4)
#  difficulte    :string(255)
#  denivele      :integer(4)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  id_openrunner :string(255)
#

class Circuit < ActiveRecord::Base
  attr_accessible :denivele, :difficulte, :direction, :longueur, :description

  has_many :programmations, :as => :programme
  has_many :rel_circuit_indications
  has_many :indications, :through => :rel_circuit_indications

  scope :filtre_km, lambda { |km_min,km_max| where("longueur >= ? and longueur < ?", km_min.to_i, km_max.to_i) }
  scope :filtre_village, lambda { |nom| where("id in (select circuit_id from rel_circuit_indications r, indications i where r.indication_id=i.id and upper(i.nom) like upper(?))", '%' + nom + '%') }

  def nom
    description
  end

  def libelle_lien
    return self.description + ' - ' +
        self.direction + ' - ' +
        self.longueur.to_s + ' km - ' +
        self.difficulte + ' - ' +
        self.denivele.to_s + ' m'
  end
end
