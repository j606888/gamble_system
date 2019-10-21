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
      r = players.normal_order.map do |player|
        hash_table[game.id][player.id]
      end
      [game.recorded_at.strftime("%F %I:%M %P") ] + r
    end

    result
  end

  def player_array
    date_array = ['遊戲時間']
    score_array = ['分數']
    players.normal_order.includes(:records).each do |p|
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
