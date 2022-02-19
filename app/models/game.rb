class Game < ApplicationRecord
  belongs_to :room
  has_many :records, dependent: :destroy
  before_create :set_recorded_at

  # TODO - use GameService::Save
  def self.save_from_array(records_array, gian_count)
    game = self.create
    records_array.each do |hash|
      next if hash[:score].nil?
      player = Player.find(hash[:id])
      player.update(gian_count: player.gian_count + gian_count)
      game.records.create(player_id: hash[:id], score: hash[:score])
    end

    line_source = game.room.line_sources.last
    message = LineBot::Designer.new(line_source).success_saved_board
    client = Line::Bot::Client.new{ |config|
      config.channel_id = ENV['GAMBLE_LINE_CHANNEL_ID']
      config.channel_secret = ENV['GAMBLE_LINE_CHANNEL_SECRET']
      config.channel_token = ENV['GAMBLE_LINE_ACCESS_TOKEN']
    }
    client.push_message(line_source.source_id, message)

    :success
  end

  def date
    recorded_at.strftime("%F")
  end

  def detail
    hash = as_json(only:[:id], methods: [:date])
    records.each { |r| hash[r.player_id] = r.score }
    hash
  end

  private

  def set_recorded_at
    self.recorded_at ||= Time.now
  end

  def self.error_message(num)
    if num.is_a?(Integer)
      num
    else
      "全數資料為0!"
    end
  end

  def self.all_zero?(records)
    records.each do |record|
      return false if record['score'] != ""
    end
    true
  end
end
