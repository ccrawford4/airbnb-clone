class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def new
    @rental = Rental.new
  end

  def create
    @rental = Rental.new(rental_params)
    if @rental.save
      redirect_to root_path, notice: "Rental created successfully"
    else
      render :new
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:category_id, :address, :score, :price)
  end
end
