# == Schema Information
#
# Table name: indications
#
#  id         :integer(4)      not null, primary key
#  nom        :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Indication < ActiveRecord::Base
  attr_accessible :nom

  has_many :rel_circuit_indications
  has_many :circuits, :through => :rel_circuit_indications

  def self.existe?(nom)
    self.find_by_nom(nom)
  end

end
