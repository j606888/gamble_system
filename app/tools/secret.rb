class Secret
  class << self
    def database
      Rails.application.credentials.send(Rails.env)[:database]
    end

    def line_api
      Rails.application.credentials.send(Rails.env)[:line_api]
    end

    def sendgrid
      Rails.application.credentials.send(Rails.env)[:sendgrid]
    end

    def omniauth
      Rails.application.credentials.send(Rails.env)[:omniauth]
    end
  end
end