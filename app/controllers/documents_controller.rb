# encoding: UTF-8
#
class DocumentsController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :destroy, :create]
  before_filter :admin_user, only: [:edit, :update, :destroy, :create]
  before_filter :documents_filter, :only => [:index]

  # GET /documents
  # GET /documents.json
  def index
    @documents = @DocumentsFiltres.paginate(page: params[:page], per_page: 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document }
    end
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(params[:document])
    if @document.save
      redirect_to @document
    else
      render 'new'
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    if @document.update_attributes(params[:document])
      redirect_to @document
    else
      render 'edit'
    end
  end

  def destroy
    Document.find(params[:id]).destroy
    flash[:success] = "Document détruit."
    redirect_to documents_path
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def maj_base
    racine = File.expand_path("../../../public", __FILE__)
    scan_dir_and_insert_new_doc(racine, racine+'/documents')

    flash[:success] = "Base documentaire mise à jour."
    redirect_to documents_path
  end

  def upload_doc
    new_document = params[:new_document]
    annee = params[:annee]
    mois = params[:mois]
    type_doc = params[:type_doc]

    #TODO Tester les champs du formulaire

    case type_doc
      when "Assemblées générales"
        then
          nom_fichier = Rails.root.join('public', 'documents', "Assemblées générales","AG_#{annee}.pdf")
      when "Sorties mensuelles"
        then
          nom_fichier = Rails.root.join('public', 'documents', "Sorties mensuelles", "#{annee}", "Sorties mensuelles #{annee} #{mois}.pdf")
      when "Lettres mensuelles"
        then
          nom_fichier = Rails.root.join('public', 'documents', "Lettres mensuelles", "#{annee}", "Lettre mensuelle  #{annee} #{mois}.pdf")
      when "Autres"
        then
          nom_fichier = Rails.root.join('public', 'documents', "Autres",new_document.original_filename)
      else

    end
    File.open(nom_fichier, 'wb') do |file|
      file.write(new_document.read)
    end

    flash[:success] = "Le document #{new_document.original_filename} a été \"uploadé\"."
    redirect_to documents_path
  end

  protected

  def documents_filter
    type_doc = params[:type_doc] || "%"
    annee_min = params[:annee_min] || 0
    annee_max = params[:annee_max] || 999999
    @DocumentsFiltres = Document.filtre_type_doc(type_doc).filtre_annee(annee_min, annee_max).order(:annee, :mois).reverse_order
  end

  private

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end


  def scan_dir_and_insert_new_doc(racine, dir)
    Dir.foreach(dir) do |dirNameLoop|
      if (!dirNameLoop.nil? && dirNameLoop != "." && dirNameLoop != "..")
        dirName = "#{dir}/#{dirNameLoop}"
        if File.directory?("#{dirName}")
          scan_dir_and_insert_new_doc(racine, dirName)
        else
          insert_new_doc(racine, dirName)
        end
      end
    end
  end

  def insert_new_doc(racine, filename)
    tabFilename = File.split(filename)
    pathRelative = tabFilename[0].gsub(racine+'/', '')
    doc = Document.where("chemin = ? and nom = ?", pathRelative, tabFilename[1]).first
    if doc.nil?
      chemin = pathRelative
      nom = tabFilename[1]
      tabNom = nom.split(" ")
      type = "#{tabNom[-4]} #{tabNom[-3]}"
      annee = tabNom[-2]
      mois = tabNom[-1].split(".")[0]
      doc = Document.create(chemin: chemin, nom: nom, type_doc: type, annee: annee, mois: mois, visibilite: "Public")
      doc.save
    end
  end

end
