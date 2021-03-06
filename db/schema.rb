# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130528053829) do

  create_table "circuits", :force => true do |t|
    t.string   "description"
    t.string   "direction"
    t.integer  "longueur"
    t.string   "difficulte"
    t.integer  "denivele"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "id_openrunner"
  end

  create_table "documents", :force => true do |t|
    t.string   "nom"
    t.string   "chemin"
    t.string   "type_doc"
    t.string   "annee"
    t.string   "mois"
    t.string   "visibilite"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "evenements", :force => true do |t|
    t.string   "description",   :limit => 1024
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.datetime "le"
    t.string   "categorie"
    t.string   "nom"
    t.string   "genre"
    t.string   "particularite"
  end

  create_table "indications", :force => true do |t|
    t.string   "nom"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "licences", :force => true do |t|
    t.string   "numero"
    t.string   "nom"
    t.string   "prenom"
    t.string   "reference"
    t.string   "adresse"
    t.string   "code_postal"
    t.string   "ville"
    t.string   "telephone"
    t.date     "naissance"
    t.string   "email"
    t.date     "inscription"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "sexe"
  end

  create_table "microposts", :force => true do |t|
    t.string   "content",    :limit => 4000
    t.integer  "user_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "old_microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "old_microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "old_relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "old_relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "old_relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "old_relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "old_users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "old_users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "old_users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "programmations", :force => true do |t|
    t.string   "groupe"
    t.datetime "le"
    t.integer  "programme_id"
    t.string   "programme_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "observations"
    t.integer  "distance"
  end

  create_table "rel_circuit_indications", :force => true do |t|
    t.integer  "rang"
    t.integer  "circuit_id"
    t.integer  "indication_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.string   "emailccc"
    t.string   "licence"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["emailccc"], :name => "index_users_on_emailccc", :unique => true
  add_index "users", ["licence"], :name => "index_users_on_licence", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
