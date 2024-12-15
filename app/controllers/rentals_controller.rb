class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def new
    @rental = Rental.new
    @rental.rental_images.build
  end

  def create
    @rental = Rental.new(rental_params)
    if @rental.save
      redirect_to root_path, notice: "Rental was successfully created."
    else
      render :new
    end
  end

  private

  def rental_params
    params.require(:rental).permit(
      :address,
      :score,
      :price,
      category_ids: [],
      rental_images_attributes: [ :image, :is_cover ]
    )
  end
end
