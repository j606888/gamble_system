class Setting < Settingslogic
  source "#{Rails.root}/config/settings/setting.yml"
  namespace Rails.env

  def liff_link(id)
    "line://app/#{liff_ids.send(id)}"
  end
end