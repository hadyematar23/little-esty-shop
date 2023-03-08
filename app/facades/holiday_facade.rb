class HolidayFacade
  
  def self.get_three_upcoming_holidays
    holidays_name_date = HolidayService.fetch_api
    
    holidays_name_date.first(3).map do |holiday|
      HolidayInfo.new(holiday)     
    end
  end
end