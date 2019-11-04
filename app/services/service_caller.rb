class ServiceCaller
  attr_accessor :result, :error

  def self.call(*args)
    begin
      service = self.new(*args)
      service.call
      service
    rescue => e
      service.error = e
      service
    end
  end

  def success?
    @error.nil?
  end
end