class ChefsController < ApplicationController

  def index
    chefs = Chef.all
    @chef = Chef.find(params[:format])
  end

  def show
    @chef = Chef.find(params[:id])
  end
end
