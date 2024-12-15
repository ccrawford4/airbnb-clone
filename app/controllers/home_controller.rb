class HomeController < ApplicationController
  def index
    @categories = Category.all
    @rentals = Rental.includes(:categories).all
  end
end
