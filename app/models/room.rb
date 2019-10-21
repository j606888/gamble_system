class Room < ApplicationRecord
  has_many :players
  has_many :games
  before_save :set_invite_token

  def hash_records    
    hash = Hash.new { |hash,key| hash[key] = {} }
    records.each { |r| hash[r.game_id][r.player_id] = r.score }

    hash
  end

  def array_records
    hash_table = hash_records
    
    result = games.order(recorded_at: :desc).map do |game|
      r = players.map do |player|
        hash_table[game.id][player.id]
      end
      [game.recorded_at.strftime("%F %T") ] + r
    end

    result
  end

  def player_array
    result = []
    result << ['遊戲時間'] + players.map { |p| p.name }
    result << ['分數'] + players.includes(:records).map { |p| p.total_score }
    result
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
