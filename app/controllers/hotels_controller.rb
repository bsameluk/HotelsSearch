class HotelsController < ApplicationController
  def search
    begin
      hotels = Hotels::Search.new(city: params[:city], number_of_adults: params[:number_of_adults]).call
    rescue => e
      return render json: { error: e.message }, status: :unprocessable_entity
    end

    render json: hotels
  end
end
