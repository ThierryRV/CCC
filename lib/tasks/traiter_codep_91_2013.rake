# encoding: UTF-8
#
require 'nokogiri'
require 'open-uri'

# rake codep91:charger

namespace :codep91_2013 do
  desc "charge le programme annuel du CODEP dans la base"
  task charger:  :environment do
    bible = File.expand_path('../../../data/FFCT-CODEP-91-2013.xml',  __FILE__)
    file_bible = File.open(bible)

    doc = Nokogiri::XML(file_bible)

    doc.css('Randonnees_permanentes Evenement').each do |evenement|
      # Creation d'un evenement
      genre = "Randonnée permanente"
      categorie = evenement.at_css('Categorie').content
      nom = evenement.at_css('Nom').content
      description = evenement.at_css('Description').content

      oEvenement = Evenement.find_by_nom(nom)
      if oEvenement.nil?
        puts "Création -- #{genre} - #{categorie} - #{nom} - #{description}"
        oEvenement = Evenement.create!(genre: genre, categorie: categorie, nom: nom, description: description)
      else
        puts "Déjà présente -- #{genre} - #{categorie} - #{nom} - #{description}"
      end

    end

    doc.css('Programme_2013 Evenement').each do |evenement|
      # Creation d'un evenement
      genre = "Programme 2013"
      categorie = evenement.at_css('Categorie').content
      leBrute = evenement.at_css('Le').content.to_s.strip
      leFormat = "#{leBrute[6..9]}-#{leBrute[3..4]}-#{leBrute[0..1]}"
      nom = evenement.at_css('Nom').content
      if !evenement.at_css('Particularite').nil?
        particularite = evenement.at_css('Particularite').content
      else
        particularite = ""
      end
      description = evenement.at_css('Description').content

      puts "#{genre} - #{categorie} - #{leFormat} - #{nom} - #{particularite} - #{description}"
      oEvenement = Evenement.create!(genre: genre, categorie: categorie, le: leFormat, nom: nom, particularite: particularite, description: description)
    end

    file_bible.close
  end
end
