# encoding: UTF-8
#
require 'nokogiri'
require 'open-uri'

namespace :programme_ccc do
  desc "charge le programme d'un mois dans la base"
  task charger: :environment do
    nomDuFichierATraiter = ask('Entrer le nom du fichier')
    programmeCCC = File.expand_path("../../../data/#{nomDuFichierATraiter}", __FILE__)
    file_programmeCCC = File.open(programmeCCC)

    doc = Nokogiri::XML(file_programmeCCC)

=begin
    <Programmations>
      <Programmation>
        <Le>02/12/2102</Le>
        <Groupe>RS &amp; R</Groupe>
        <Programme_type>Circuit</Programme_type>
        <Programme_nom>26 B</Programme_nom>
        <Distance>65</Distance>
        <Heure_de_départ>9h00</Heure_de_départ>
        <Observation>
          **Sud/ Barbizon**
        </Observation>
      </Programmation>
=end

    doc.css('Programmation').each do |programme|
      # Get common elements
      nom = programme.at_css('Programme_nom').content
      distance = programme.at_css('Distance').content
      groupe = programme.at_css('Groupe').content
      observations = programme.at_css('Observations').content.strip
      leBrute = programme.at_css('Le').content.to_s.strip
      leFormat = "#{leBrute[6..9]}-#{leBrute[3..4]}-#{leBrute[0..1]}"
      heureBrute = programme.at_css('Heure_de_départ').content.to_s.strip
      le_heure = leBrute + ' ' + heureBrute + ':00'

      distance = programme.at_css('Distance').content.to_i

      # Is it a Circuit or a Evenement ?
      programme_type = programme.at_css('Programme_type').content
      if programme_type=='Circuit'
        oProgramme = Circuit.find_by_description(nom)
        if oProgramme.longueur != distance
          puts " !!!! distance du programme (#{distance}) <> distance du circuit (#{oProgramme.longueur})"
          distance = oProgramme.longueur
        end
      else
        oProgramme = Evenement.find_by_nom(nom)
        if oProgramme.nil?
          oProgramme = Evenement.create!(nom: nom, genre: "Programme 2013", categorie: "ROUTE",
                                           description: observations, le: leBrute)
        end
      end

      puts "#{groupe} - #{le_heure} - #{oProgramme.id} - #{distance} - #{programme_type} - #{observations}"
      oProgrammation = Programmation.create!(groupe: groupe, le: le_heure, programme_id: oProgramme.id,
                                             programme_type: programme_type, observations: observations, distance: distance)
      puts "#{oProgrammation}"
    end
  end
end

  def ask message
    print "#{message} : "
    STDIN.gets.chomp
  end


