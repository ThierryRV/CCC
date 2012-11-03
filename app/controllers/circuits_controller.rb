# encoding: UTF-8
#
class CircuitsController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :destroy,:create]
  before_filter :admin_user, only: [:edit, :update, :destroy,:create]


  def index
    @circuits = Circuit.paginate(page: params[:page])
  end

  def show
    @circuit = Circuit.find(params[:id])
  end


  def new
    @circuit = Circuit.new
  end

  def create
    @circuit = Circuit.new(params[:circuit])
    if @circuit.save
      redirect_to @circuit
    else
      render 'new'
    end
  end

  def edit
    @circuit = Circuit.find(params[:id])
  end

  def update
    @circuit = Circuit.find(params[:id])
    if @circuit.update_attributes(params[:circuit])
      redirect_to @circuit
    else
      render 'edit'
    end
  end

  def destroy
    Circuit.find(params[:id]).destroy
    flash[:success] = "Circuit détruit."
    redirect_to circuits_path
  end

  private

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
