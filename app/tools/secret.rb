class Secret
  class << self
    def line_api
      Rails.application.credentials.send(Rails.env)[:line_api]
    end
  end
end