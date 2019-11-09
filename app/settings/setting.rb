class Setting < Settingslogic
  source "#{Rails.root}/config/settings/setting.yml"
  namespace Rails.env
end