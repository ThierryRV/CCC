class EvenementsController < ApplicationController
  def index
    @evenements = Evenement.paginate(page: params[:page])
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
end
