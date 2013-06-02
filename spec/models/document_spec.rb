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

require 'spec_helper'

describe Document do
  pending "add some examples to (or delete) #{__FILE__}"
end
