# == Schema Information
#
# Table name: rel_circuit_indications
#
#  id            :integer(4)      not null, primary key
#  rang          :integer(4)
#  circuit_id    :integer(4)
#  indication_id :integer(4)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class RelCircuitIndication < ActiveRecord::Base
  attr_accessible :circuit_id, :indication_id, :rang

  belongs_to :circuit
  belongs_to :indication
end
