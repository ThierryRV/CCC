# encoding: UTF-8
#
require 'nokogiri'
require 'open-uri'

namespace :programme_ccc do
  desc "charge la bible des circuits dans la base"
  task charger: :environment do
    nomDuFichierATraiter = ask('Entrer le nom du fichier')
    programmeCCC = File.expand_path("../../../data/#{nomDuFichierATraiter}", __FILE__)
    file_programmeCCC = File.open(programmeCCC)

    doc = Nokogiri::XML(file_programmeCCC)

    doc.css('Programmation').each do |programme|
      # Get common elements
      nom = programme.at_css('Programme_nom').content
      distance = programme.at_css('Distance').content
      groupe = programme.at_css('Groupe').content
      observations = programme.at_css('Observations').content
      leBrute = programme.at_css('Le').content.to_s.strip
      leFormat = "#{leBrute[6..9]}-#{leBrute[3..4]}-#{leBrute[0..1]}"
      heureBrute = programme.at_css('Heure_de_départ').content.to_s.strip
      le_heure = leBrute + ' ' + heureBrute + ':00'

      # Is it a Circuit or a Evenement ?
      programme_type = programme.at_css('Programme_type').content
      if programme_type=='Circuit'
        oProgramme = Circuit.find_by_description(nom)
      else
        oProgramme = Evenement.find_by_nom(nom)
        if oProgramme.nil?
          oProgramme = Evenement.create!(nom: nom, genre: "Programme 2012", categorie: "ROUTE",
                                           description: observations, le: leBrute)
        end
      end

      puts "#{groupe} - #{le_heure} - #{oProgramme.id} - #{programme_type} - #{observations}"
      oProgrammation = Programmation.create!(groupe: groupe, le: le_heure, programme_id: oProgramme.id,
                                             programme_type: programme_type, observations: observations)
      puts "#{oProgrammation}"
    end
  end
end

  def ask message
    print "#{message} : "
    STDIN.gets.chomp
  end


