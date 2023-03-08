class HolidayService
  def self.fetch_api
    response = connection.get
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new(url: "https://date.nager.at/api/v3/NextPublicHolidays/US")
  end
end