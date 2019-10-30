class Sample < Settingslogic
  source "#{Rails.root}/config/settings/sample.yml"
  namespace Rails.env
end