class ServiceCaller
  attr_accessor :result, :error

  def self.call(*args)
    service = self.new(*args)
    service.call
    service
  end

  def success?
    @error.nil?
  end
end