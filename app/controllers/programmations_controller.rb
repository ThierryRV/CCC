# encoding: UTF-8
#
class ProgrammationsController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :destroy,:create]
  before_filter :admin_user, only: [:edit, :update, :destroy,:create]
  before_filter :programmations_filter, :only => [:index]

  def index
    @programmations = @ProgrammationsFiltres.paginate(page: params[:page], per_page: 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @programmations }
    end
  end

  def show
    @programmation = Programmation.find(params[:id])
  end

 def edit
  end

  def create
  end

  def destroy
  end

  protected

  def programmations_filter
    annee_min = params[:annee_min] || 2013
    annee_max = params[:annee_max] || 9999
    date_min = Time.local(annee_min, 1, 1)
    date_max = Time.local(annee_max, 12, 31)
    @ProgrammationsFiltres = Programmation.filtre_annee(date_min, date_max).order(:le).reverse_order
  end

end
