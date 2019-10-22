class Room < ApplicationRecord
  has_many :players
  has_many :games
  before_save :set_invite_token

  def hash_records    
    hash = Hash.new { |hash,key| hash[key] = {} }
    records.each { |r| hash[r.game_id][r.player_id] = r.score }

    hash
  end

  def body_array(type)
    hash_table = hash_records
    player_hash = players.avaliable.send(type)

    games.order(recorded_at: :desc).map do |game|
      single_game = player_hash.map { |p| hash_table[game.id][p.id] }
      [game.recorded_at.strftime("%F %I:%M %P")] + single_game
    end
  end

  def header_array(type)
    date_array = ['遊戲時間']
    score_array = ['分數']

    players.avaliable.send(type).each do |p|
      date_array << p.name
      score_array << p.total_score
    end
    [date_array, score_array]
  end

  def records
    arrays = []
    games.includes(:records).each do |g|
      arrays += g.records
    end
    arrays
  end

  private
  def set_invite_token
    self.invite_token = SecureRandom.hex(3)
  end
end
