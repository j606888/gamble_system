class AdviseTool < ServiceCaller
  def initialize(advise_params)
    @advise_params = advise_params
  end

  def call
    advise_array = Rails.cache.fetch(:advise) do
      []
    end
    advise_array << @advise_params
    Rails.cache.write(:advise, advise_array)
  end
end