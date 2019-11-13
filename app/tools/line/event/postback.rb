module Line::Event::Postback
  def data
    raise "not postback type" unless is_postback?
    JSON.parse @postback['data']
  end

  def is_postback?
    @type == 'postback'
  end
end