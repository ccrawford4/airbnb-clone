class HomeController < ApplicationController
  def index
    @rentals = Rental.all
  end
end
