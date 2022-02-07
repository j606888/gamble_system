class Service
  class PerformFailed < StandardError
    attr_reader :code
    def initialize(message, code: nil)
      @code = code
      super(message)
    end
  end

  def perform
    raise "#{self.class.name} should implement #perform"
  end
end
