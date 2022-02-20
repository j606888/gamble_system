module LiffHelper
  def liff_url path, room_id
    "https://liff.line.me/#{ENV['LINE_LIFF_ID']}/#{path}/?room_id=#{room_id}"
  end
end
