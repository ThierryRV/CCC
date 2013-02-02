# == Schema Information
#
# Table name: programmations
#
#  id             :integer(4)      not null, primary key
#  groupe         :string(255)
#  le             :datetime
#  programme_id   :integer(4)
#  programme_type :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  observations   :string(255)
#

class Programmation < ActiveRecord::Base
  attr_accessible :groupe, :le, :programme_id, :programme_type, :observations

  belongs_to :programme, :polymorphic => true, dependent: :destroy

#  default_scope order: 'programmations.le DESC'

  #def self.next_10_dates(from)
  #  return Programmation.where("le >= ?",from).order("le asc").limit(10)
  #end

  def self.next_10_dates()
    return Programmation.where("le >= ?",Date.current()).order("le asc").limit(10)
  end




end
