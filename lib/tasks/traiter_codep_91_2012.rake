# encoding: UTF-8
#
require 'nokogiri'
require 'open-uri'

## Get a Nokogiri::HTML:Document for the page we’re interested in...
#
#doc = Nokogiri::HTML(open('http://www.google.com/search?q=tenderlove'))
#
## Do funky things with it using Nokogiri::XML::Node methods...
#
#####
## Search for nodes by css
#doc.css('h3.r a').each do |link|
#puts link.content
#end
#
######
## Search for nodes by xpath
#doc.xpath('//h3/a').each do |link|
#puts link.content
#end
#
#####
## Or mix and match.
#doc.search('h3.r a.l', '//h3/a').each do |link|
#puts link.content
#end

namespace :codep91 do
  desc "charge la bible des circuits dans la base"
  task charger:  :environment do
    bible = File.expand_path('../../../data/FFCT-CODEP-91-2012.xml',  __FILE__)
    file_bible = File.open(bible)

    doc = Nokogiri::XML(file_bible)

    doc.css('Randonnees_permanentes Evenement').each do |evenement|
      # Creation d'un evenement
      type = "Randonnée permanente"
      categorie = evenement.at_css('Categorie').content
      nom = evenement.at_css('Nom').content
      description = evenement.at_css('Description').content

      puts "#{type} - #{categorie} - #{nom} - #{description}"
      oEvenement = Evenement.create!(type: type, categorie: categorie, nom: nom, description: description)
    end

    doc.css('Programme_2012 Evenement').each do |evenement|
      # Creation d'un evenement
      type = "Programme 2012"
      categorie = evenement.at_css('Categorie').content
      leBrute = evenement.at_css('Le').content.to_s.strip
      leFormat = "#{leBrute[6..9]}-#{leBrute[3..4]}-#{leBrute[0..1]}"
      nom = evenement.at_css('Nom').content
      description = evenement.at_css('Description').content

      puts "#{type} - #{categorie} - #{leFormat} - #{nom} - #{description}"
      oEvenement = Evenement.create!(type: type, categorie: categorie, le: leFormat, nom: nom, description: description)
    end

    file_bible.close
  end
end
