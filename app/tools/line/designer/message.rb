module Line::Designer::Message
  # first_time_finish

  def player_not_found
    text("暱稱(#{@options[:nickname]})不存在，請重新確認！")
  end
end