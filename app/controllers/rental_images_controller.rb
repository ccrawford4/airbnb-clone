class RentalImagesController < ApplicationController
  def create
    @rental_image = RentalImage.new(rental_image_params)

    if @rental_image.save
      render json: @rental_image, status: :created
    else
      render json: { success: false, errors: @rental_image.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private
  def rental_image_params
    params.require(:rental_image).permit(:image_blob_id, :position, :rental_id)
  end
end
