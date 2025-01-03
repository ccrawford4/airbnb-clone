class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end

  def show
    @rental = Rental.find(params[:id])

    # To Show all the images do something like @post.as_json(include: images).merge(
    # images: @post.images.map do |image|
    # url_for(image)
    # end
    # )
    #
  end

  protect_from_forgery with: :null_session, only: [ :new, :update ]
  before_action :load_location_data, only: [ :new ], render: "new"

  def new
    @rental = Rental.create()
    @rental_type_id = params[:rental_type_id] || nil
    @logo_url = "https://airbnb-clone1.s3.us-west-1.amazonaws.com/protected-assets/airbnb-logo-black-white-background.jpg"
    @current_step = params[:step].to_i || 1
    @rental_types = RentalType.all
    @selected_rental_type = RentalType.find(@rental_type_id) if @rental_type_id

    Rails.logger.debug "Session address: #{session[:address]}"

    # Assign address from session
    # @address = session[:address]

    Rails.logger.debug "Instance address: #{@address}"
    render "new"
    # @rental = rental.new_record? ? rental : rental.new
    # @location = params[:location] || "San Francisco, CA"
    # @current_step = params[:step] || 1
    # @rental_types = RentalType.all
    # @selected_rental_type = params[:rental_type_id] ? RentalType.find(params[:rental_type_id]) : nil
    # @num_guests = params[:num_guests] || 1
    # @num_bathrooms = params[:num_bathrooms] || 1
    # @num_bedrooms = params[:num_bedrooms] || 1
    # @num_beds = params[:num_beds] || 1

    # if request.patch?
    #   if params[:rental_type_id]
    #     @selected_rental_type = RentalType.find(params[:rental_type_id])
    #     render json: { success: true }
    #   elsif params[:location]
    #     @location = params[:location]
    #     render "new"
    #   elsif params[:address] && params[:state] && params[:zipcode]
    #     # Update the location details
    #     @location = {
    #       address: params[:address],
    #       state: params[:state],
    #       zipcode: params[:zipcode]
    #     }
    #     render "new"
    #   end
    # else
    #   render "new"
    # end

    # session.delete(:address)
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
