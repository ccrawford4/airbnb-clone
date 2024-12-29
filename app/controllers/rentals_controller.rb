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

  def create
    @rental = Rental.create()
  end

  # def update
  #   # would have to recreate them
  #   @location = params[:location] || "San Francisco, CA"
  #   @logo_url = "https://airbnb-clone1.s3.us-west-1.amazonaws.com/protected-assets/airbnb-logo-black-white-background.jpg"
  #   @current_step = params[:step] || 1
  #   @rental_types = RentalType.all
  #   @selected_rental_type = params[:rental_type_id] ? RentalType.find(params[:rental_type_id]) : nil

  #   render "new"
  # end

  def update_rental_type_id
    @rental_type_id = params[:rental_type_id]
  end

  def update
    body = request.body.read
    data = JSON.parse(body)

    @city = data["city"]
    @state = data["state"]
    @country = data["country"]
    @zipcode = data["zipcode"]
    @address = data["address"]
    @latitude = data["latitude"]
    @longitude = data["longitude"]

    Rails.logger.debug "Storing address in session: #{session[:address]}"
    puts "Storing address in session: #{session[:address]}"

    render json: {
      success: true,
      city: @city,
      state: @state,
      country: @country,
      zipcode: @zipcode,
      address: @address,
      latitude: @latitude,
      longitude: @longitude
    }
  end

  private
  def load_location_data
    @address = session[:address]
  end
end
