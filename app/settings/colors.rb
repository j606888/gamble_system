class Colors < Settingslogic
  source "#{Rails.root}/config/settings/colors.yml"
  namespace Rails.env

  def order_pick(id, type)
    total_count = send(type).count
    send(type)[id % total_count]
  end

  def rgba_array(array)
    blue_string = rgba_string.blue
    red_string = rgba_string.red
    result = []

    win_array = array.select { |n| n >= 0 }
    win_percent = 1.0 / win_array.count
    start = 1
    win_array.each do |n|
      result << blue_string.sub("%per", start.to_s)
      start -= win_percent
    end

    lose_array = array.select { |n| n < 0 }
    lose_percent = 1.0 / lose_array.count
    start = 0
    lose_array.each do |n|
      start += lose_percent
      result << red_string.gsub("%per", start.to_s)
    end
      
    result
  end
end