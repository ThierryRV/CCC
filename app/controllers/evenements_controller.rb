# encoding: UTF-8
#
class EvenementsController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :destroy,:create]
  before_filter :admin_user, only: [:edit, :update, :destroy,:create]
  before_filter :evenements_filter, :only => [:index]

  def index
    @evenements = @EvenementsFiltres.paginate(page: params[:page], per_page: 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @evenements }
    end
  end

  def show
    @evenement = Evenement.find(params[:id])
  end

  def edit
  end

  def create
  end

  def destroy
  end

  protected

  def evenements_filter
    annee_min = params[:annee_min] || 2013
    annee_max = params[:annee_max] || 9999
    date_min = Time.local(annee_min, 1, 1)
    date_max = Time.local(annee_max, 12, 31)
    @EvenementsFiltres = Evenement.filtre_annee(date_min, date_max).order(:le).reverse_order
  end

end
