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
    result = {
      winner: [],
      loser: [],
      counter: []
    }

    winner_hash = players.avaliable.winner
    loser_hash = players.avaliable.loser
    counter_hash = players.avaliable.counter

    games.order(recorded_at: :desc).each do |game|
      winner_game = winner_hash.map { |p| hash_table[game.id][p.id] }
      loser_game = loser_hash.map { |p| hash_table[game.id][p.id] }
      counter_game = counter_game.map { |p| hash_table[game.id][p.id] }

      result[:winner] << [game.recorded_at.strftime("%F %I:%M %P")] + winner_game
      result[:loser] << [game.recorded_at.strftime("%F %I:%M %P")] + loser_game
      result[:counter] << [game.recorded_at.strftime("%F %I:%M %P")] + counter_game
    end

    result
  end

  def player_array
    result = {}
    result[:winner] = scope_player(:winner)
    result[:loser] = scope_player(:loser)
    result[:counter] = scope_player(:winner)

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

  def scope_player(type)
    date_array = ['遊戲時間']
    score_array = ['分數']

    players.avaliable.send(type).each do |p|
      date_array << p.name
      score_array << p.total_score
    end
    [date_array, score_array]
  end
end
