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

  def edit
    @rental = Rental.find(params[:id])
    @rental_image = RentalImage.find_by(rental_id: @rental.id)
    if @rental_image.nil?
      render "error"
    end
  end

  def create
    @rental = Rental.create(rental_params)
    if @rental.save
      redirect_to root_path, notice: "Rental was successfully created."
    else
      render :new
    end
  end

  def update
    @rental = Rental.find(params[:id])
    @rental_image = RentalImage.find_by(rental_id: @rental.id)

    ActiveRecord::Base.transaction do
      # Extract nested attributes for the first rental image
      image_attributes = rental_params[:rental_images_attributes]["0"]

      if @rental_image.update(
        is_cover: image_attributes[:is_cover],
        description: image_attributes[:description]
      )
        if @rental.update(rental_params.except(:rental_images_attributes))
          redirect_to show, notice: "Rental was successfully updated."
        else
          raise ActiveRecord::Rollback
        end
      else
        raise ActiveRecord::Rollback
      end
    end
  rescue ActiveRecord::Rollback
    render :edit
  end

  def destroy
    @rental = Rental.find(params[:id])
    @rental_image = RentalImage.find_by(rental_id: @rental.id)
    if @rental_image.present?
      @rental_image.image.purge
      @rental_image.destroy
    end
    @rental.destroy
    redirect_to root_path, notice: "Rental was successfully destroyed."
  end

  private

  def rental_params
    params.require(:rental).permit(
      :short_description,
      :address,
      :score,
      :price,
      category_ids: [],
      rental_images_attributes: [ :image, :is_cover, :description ]
    )
  end
end
