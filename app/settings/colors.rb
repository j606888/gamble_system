class Colors < Settingslogic
  source "#{Rails.root}/config/settings/colors.yml"
  namespace Rails.env

  def order_pick(id)
    total_count = basic_color.count
    basic_color[id % total_count]
  end
end