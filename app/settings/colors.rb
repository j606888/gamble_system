class Colors < Settingslogic
  source "#{Rails.root}/config/settings/colors.yml"
  namespace Rails.env

  def order_pick(id, type)
    total_count = send(type).count
    send(type)[id % total_count]
  end
end