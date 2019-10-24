class Room < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :games, dependent: :destroy
  before_save :set_invite_token

  ALLOW_REPORT_TYPE = %w[winner loser counter]

  def records
    arrays = []
    games.includes(:records).each do |g|
      arrays += g.records
    end
    arrays
  end

  def report(type='winner')
    raise 'not allow type' if ALLOW_REPORT_TYPE.exclude?(type)
    hash = {}
    hash[:header] = header_maker(type)
    hash[:body] = body_maker
    hash
  end

  private
  def header_maker(type='winner')
    select_players = players.avaliable.send(type)
    {
      name: ['遊戲時間'] + select_players.map(&:name),
      money: ['分數'] + select_players.map(&:total_score),
      id: select_players.map(&:id)
    }
  end

  def body_maker
    hash = {}
    games.order(id: :desc).includes(:records).each do |game|
      game_hash = { id: game.id }
      game.records.each do |record|
        game_hash[record.player_id] = record.score
      end
      hash[game.display_time] = game_hash
    end
    hash
  end

  def set_invite_token
    self.invite_token = SecureRandom.hex(3)
  end
end
