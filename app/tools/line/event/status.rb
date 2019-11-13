module Line::Event::Status
  ALLOW_STATUS = %i[initial bind_room]
  def current_status
    return @event_status if @event_status.present?
    @event_status = Rails.cache.fetch("line:status:#{line_source.id}") { 'initial' }
  end
end