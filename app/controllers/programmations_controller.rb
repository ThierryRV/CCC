# encoding: UTF-8
#
class ProgrammationsController < ApplicationController
  def index
    @programmations = Programmation.paginate(page: params[:page])
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
end
