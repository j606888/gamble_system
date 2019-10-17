class Room < ApplicationRecord
  has_many :players
  has_many :games
  before_save :set_invite_token

  def all_records
    records = {}
    games.each do |game|
      records[game.recorded_at] = game.sort_record
    end
  end

  private
  def set_invite_token
    self.invite_token = SecureRandom.hex(3)
  end
end
