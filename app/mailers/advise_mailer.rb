class AdviseMailer < ApplicationMailer
  ME = 'j606888@gmail.com'
  def remind
    @advise = Rails.cache.read(:advise).last

    mail(to: ME, subject: "麻將小幫手：新建議！")
  end
end
