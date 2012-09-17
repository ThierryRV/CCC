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
