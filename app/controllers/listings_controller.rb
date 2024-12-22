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
      end
    else
      render "new"
    end
  end
end
