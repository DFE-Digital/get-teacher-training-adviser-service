module NextDayFilter
  def next_day_check(options)
    options.shift if Date.parse(options.keys.first) == Date.today
    options
  end
end
