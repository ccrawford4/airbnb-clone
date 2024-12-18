class ListingsController < ApplicationController
  def new
    @logo_url = "https://airbnb-clone1.s3.us-west-1.amazonaws.com/protected-assets/airbnb-logo-black-white-background.jpg"
    @current_step = params[:step] || 1
    @rental_types = RentalType.all
    render "new"
  end
end
