module Line::Event::Postback
  def data
    raise "not postback type" unless is_postback?
    @postback['data']
  end

  def is_postback?
    @type == 'postback'
  end
end