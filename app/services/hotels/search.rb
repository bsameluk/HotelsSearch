class Hotels::Search
  attr_accessor :city, :number_of_adults

  CLIENT_ID = "boom_3a213702291c3df84814".freeze
  CLIENT_SECRET = "76df8d0d9bf2a21b04b4a64504c1107ed9b4078b3a3b1fd722687a9f399e7c76".freeze

  def initialize(city:, number_of_adults:)
    @city = city
    @number_of_adults = number_of_adults

    _validate_params
  end

  def call
    token = _get_token

    @hotels = _search_hotels_in_external_api(token)
  end

  private

  def _get_token
    response = HTTParty.post(
      "https://app.boomnow.com/open_api/v1/auth/token",
      headers: {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      },
      body: {
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET
      }.to_json
    )

    if response.success?
      parsed_response = response.parsed_response
      parsed_response["access_token"]
    else
      Rails.logger.error("Error when getting token: #{response.code} - #{response.message}")
      raise "Can't get token"
    end
  rescue StandardError => e
    Rails.logger.error("Error when getting token: #{e.message}")
    raise
  end

  def _search_hotels_in_external_api(token)
    response = HTTParty.get(
      "https://app.boomnow.com/open_api/v1/listings",
      headers: {
        "Accept" => "application/json",
        "Authorization" => "Bearer #{token}"
      },
      query: {
        city: city,
        adults: number_of_adults
      }
    )

    if response.success?
      parsed_response = response.parsed_response
      parsed_response["listings"] || []
    else
      Rails.logger.error("Error when requesting API: #{response.code} - #{response.message}")
      []
    end
  rescue StandardError => e
    Rails.logger.error("Error when getting hotels: #{e.message}")
    []
  end

  def _validate_params
    raise "City is required" if @city.blank?
    raise "Number of adults is required" if @number_of_adults.blank?
  end
end
