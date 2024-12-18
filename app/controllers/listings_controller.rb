class ListingsController < ApplicationController
  def new
    @current_step = params[:step] || 1
    render "new"
  end
end
