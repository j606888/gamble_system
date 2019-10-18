class Room < ApplicationRecord
  has_many :players
  has_many :games
  before_save :set_invite_token

  def all_records
    hash = Hash.new
    Game.all.each { |g| hash[g.id] = g.recorded_at }
    binding.pry
    Record.all.each { |r| hash[r.game_id][r.player_id] = r.score }
    hash
  end

  private
  def set_invite_token
    self.invite_token = SecureRandom.hex(3)
  end
end
