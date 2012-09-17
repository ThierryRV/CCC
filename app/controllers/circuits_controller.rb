class CircuitsController < ApplicationController
  def index
    @circuits = Circuit.paginate(page: params[:page])
  end

  def show
    @circuit = Circuit.find(params[:id])
  end

  def edit
  end

  def create
  end

  def destroy
  end
end
