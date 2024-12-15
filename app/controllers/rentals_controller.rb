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
      @rental.categories = Category.find(params[:rental][:category_ids].reject(&:blank?))
      redirect_to root_path, notice: "Rental was successfully created."
    else
      render :new
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:address, :score, :price, category_ids: [])
  end
end
