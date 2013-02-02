# == Schema Information
#
# Table name: evenements
#
#  id            :integer(4)      not null, primary key
#  description   :string(1024)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  le            :datetime
#  categorie     :string(255)
#  nom           :string(255)
#  genre         :string(255)
#  particularite :string(255)
#

class Evenement < ActiveRecord::Base
  attr_accessible :genre, :le, :categorie, :nom, :description, :particularite

  has_many :programmations, :as => :programme

  default_scope order: 'evenements.le DESC'

end
