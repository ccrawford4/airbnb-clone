class ListingsController < ApplicationController
  protect_from_forgery with: :null_session, only: [ :new ]

  def new
    @location = params[:location] || "San Francisco, CA"
    @logo_url = "https://airbnb-clone1.s3.us-west-1.amazonaws.com/protected-assets/airbnb-logo-black-white-background.jpg"
    @current_step = params[:step] || 1
    @rental_types = RentalType.all
    @selected_rental_type = params[:rental_type_id] ? RentalType.find(params[:rental_type_id]) : nil

    if request.patch?
      if params[:rental_type_id]
        @selected_rental_type = RentalType.find(params[:rental_type_id])
        render json: { success: true }
      elsif params[:location]
        @location = params[:location]
        render "new"
      elsif params[:address] && params[:state] && params[:zipcode]
        # Update the location details
        @location = {
          address: params[:address],
          state: params[:state],
          zipcode: params[:zipcode]
        }
        render "new"
      end
    else
      render "new"
    end
  end

  def update
    @location = params[:location] || "San Francisco, CA"
    @logo_url = "https://airbnb-clone1.s3.us-west-1.amazonaws.com/protected-assets/airbnb-logo-black-white-background.jpg"
    @current_step = params[:step] || 1
    @rental_types = RentalType.all
    @selected_rental_type = params[:rental_type_id] ? RentalType.find(params[:rental_type_id]) : nil

    render "new"
  end

  def update_location
    # Assuming you have a Listing model and you are updating the current listing
    @listing = Listing.find(params[:id])
    if @listing.update(city: params[:city], zipcode: params[:zipcode])
      render json: { success: true }
    else
      render json: { success: false }
    end
  end
end
