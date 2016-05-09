require 'time'
require 'date'

class BusinessHours

  def initialize(start_time,end_time)
  	@start = start_time
  	@end = end_time
  	@special_leave = Hash.new()
  	@weekly_leave = Hash.new()
  	@weekly_change_of_time = Hash.new()
  	@special_change_of_time = Hash.new()
  end

  def closed(*days)
  	days.each { |x|
  	  if x.is_a? Symbol
  	  	@weekly_leave[x] = true
  	  else
  	  	date = Date.parse x
  	  	@special_leave[date] = true
  	  end
  	}
  end

  def update(date_or_day, start, end_time)
  	if date_or_day.is_a? Symbol
  	  @weekly_change_of_time[date_or_day] = [start,end_time]
  	else
  	  date_or_day = Date.parse date_or_day
  	  @special_change_of_time[date_or_day] = [start,end_time]
  	end
  end

  def print_me(time)
  	date = Date.parse time.to_s
  	#time = Time.parse time.to_s
  	the_day = date.strftime("%a %b %d")
  	the_h = time.strftime("%H:%M:%S %Y")
  	puts "#{the_day} #{the_h}"
  end

  # Recursive function that calculates the result
  def calculate_deadline(interval,date_string)
  	date = Date.parse date_string.to_s
  	time = Time.parse date_string.to_s

  	if is_in_current_working_day date_string
  	  rem = time_remaining interval,date_string
  	  if rem > interval
  	  	# End condition
  	  	print_me time + interval
  	  else
  	  	interval -= rem
  	  	time = next_business_day date+1
  	  	calculate_deadline interval,time
  	  end
  	else
  		time = next_business_day date_string
  		calculate_deadline interval,time
  	end
  end

  # Checks if the given date_string is in a working time Eg: from given eg: 8:59 is not working time and 9:00 is working time
  def is_in_current_working_day(date_string)
  	date = Date.parse date_string.to_s
  	time = Time.parse date_string.to_s
  	the_day = date.strftime("%a").downcase.to_sym
  	
  	return false if @weekly_leave[the_day] == true || @special_leave[date] == true

  	if @special_change_of_time[date]
  	  st = @special_change_of_time[date][0]
  	  en = @special_change_of_time[date][1]
  	elsif @weekly_change_of_time[the_day]
  	  st = @weekly_change_of_time[the_day][0]
  	  en = @weekly_change_of_time[the_day][1]
  	else
  	  st = @start
  	  en = @end
  	end

  	st = Time.parse st+" "+date.to_s
  	en = Time.parse en+" "+date.to_s

  	return false if time < st || time > en
  	return true
  end


  # Given a time, this will return the next working day ( actually next working time )
  def next_business_day(date_string)
  	date = Date.parse date_string.to_s
  	time = Time.parse date_string.to_s
  	the_day = date.strftime("%a").downcase.to_sym

  	unless @special_leave[date] || @weekly_leave[the_day]
  	  if @special_change_of_time[date] != nil
  	  	st = @special_change_of_time[date][0]
  	  elsif @weekly_change_of_time[the_day] != nil
  	  	st = @weekly_change_of_time[the_day][0]
  	  else
  	  	st = @start
  	  end
  	  st = Time.parse st+" "+date.to_s
  	  return st
  	else
  	  next_business_day date+1
  	end
  end


  # Helper function to subtract todays work from the interval
  def time_remaining(interval,date_string)
  	date = Date.parse date_string.to_s
  	the_day = date.strftime("%a").downcase.to_sym
  	time = Time.parse date_string.to_s

  	if @special_change_of_time[date]
  	  en = @special_change_of_time[date][1]
  	elsif @weekly_change_of_time[the_day]
  	  en = @weekly_change_of_time[the_day][1]
  	else
  	  en = @end
  	end

  	en = Time.parse en+" "+date.to_s
  	return en - time
  end

end

hours = BusinessHours.new("9:00 AM", "3:00 PM")
hours.update :fri, "10:00 AM", "5:00 PM"
hours.update "Dec 24, 2010", "8:00 AM", "1:00 PM"	
hours.closed :sun, :wed, "Dec 25, 2010"
hours.closed "Dec 26, 2010"
hours.calculate_deadline(2*60*60, "Jun 7, 2010 9:10 AM")
hours.calculate_deadline(15*60, "Jun 8, 2010 2:48 PM")
hours.calculate_deadline(3*60*60, "Dec 24, 2010 12:45 PM")


