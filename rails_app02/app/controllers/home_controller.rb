class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: { status: 'success', message: 'Welcome to the API' } }
    end
  end
end