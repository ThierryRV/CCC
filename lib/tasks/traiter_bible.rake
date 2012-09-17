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
#####
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


namespace :bible do
  desc "charge la bible des circuits dans la base"
  task charger:  :environment do
    bible = File.expand_path('../../../data/BibleCCC.xml',  __FILE__)
    file_bible = File.open(bible)

    doc = Nokogiri::XML(file_bible)
    doc.css('Circuit').each do |circuit|
      # Creation d'un circuit
      numero = circuit.at_css('Numero').content
      direction = circuit.at_css('Direction').content
      longueur = circuit.at_css('Longueur').content
      difficulte = circuit.at_css('Difficulte').content
      denivele = circuit.at_css('Denivele').content

      puts "#{numero} - #{direction} - #{longueur} - #{difficulte} - #{denivele}"
      oCircuit = Circuit.create!(description: numero, direction: direction, longueur: longueur,
                                 difficulte: difficulte, denivele: denivele)

      i=0
      circuit.css('Etapes Etape').each do |etape|
        i = i + 1
        nom = etape.content
        if Indication.existe?(nom)
          oIndication = Indication.find_by_nom(nom)
        else
          oIndication = Indication.create!(nom: nom)
        end
        oRelCircuitIndication = RelCircuitIndication.create!(rang: i, circuit_id: oCircuit.id,
                                                             indication_id: oIndication.id)
#        puts " #{i} #{etape.content} - "
      end

      circuit.css('Dates Date').each do |date|
#        22/08/10
        dateBrute = date.content.to_s.strip
        dateFormat = "20#{dateBrute[6..7]}-#{dateBrute[3..4]}-#{dateBrute[0..1]}"
        oProgrammation = Programmation.create!(groupe: "", le: dateFormat,
                                               programme_id: oCircuit.id, programme_type: "Circuit")
        puts " #{dateBrute[0..7]} #{dateFormat} - "
      end

    end
    file_bible.close
  end
end

def make_users
  admin = User.create!(name: "Example User",
                       email: "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end