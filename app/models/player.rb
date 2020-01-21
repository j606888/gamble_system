class Player < ApplicationRecord
  belongs_to :room
  has_many :records, dependent: :destroy
  before_update :upper_nickname!
  before_create :nickname_check!

  scope :avaliable, -> { where(hidden: false).order(:id) }
  scope :winner, -> { includes(:records).all.sort_by(&:total_score).reverse! }
  scope :loser, -> { includes(:records).all.sort_by(&:total_score) }
  scope :counter, -> { includes(:records).all.sort_by(&:game_times).reverse! }

  def self.score_array(players)
    players.map do |player|
      {
        id: player.id,
        score: nil,
        name: "#{player.name}(#{player.nickname})"
      }
    end
  end

  def total_score
    records.map(&:score).compact.sum
  end

  def game_times
    records.count
  end

  def analyse
    game_count = win_count = lose_count = total_score = 0
    records.each do |record|
      game_count += 1
      total_score += record.score
      win_count += 1 if record.score > 0
      lose_count += 1 if record.score < 0
    end

    win_rate = win_count.to_f / ( win_count + lose_count )
    win_rate = 0 if win_rate.nan?
    {
      id: id,
      name: name,
      total_score: total_score,
      game_count: game_count,
      gian_count: gian_count,
      win: win_count,
      lose: lose_count,
      win_rate: "#{(win_rate * 100).to_i}%",
      average: (total_score.to_f / game_count).round(2)
    }
  end

  def date_report
    records.includes(:game).map do |record|
      {
        date: record.game.date,
        score: record.score
      }
    end
  end

  private
  def upper_nickname!
    self.nickname = nickname.upcase
  end

  def nickname_check!
    return if room.players.find_by(nickname: nickname).nil? && nickname.present?
    
    ('A'..'Z').each do |alph|
      self.nickname = alph
      break if room.players.find_by(nickname: nickname).nil?
    end

    return if room.players.find_by(nickname: nickname).nil?

    loop do
      self.nickname = SecureRandom.hex(2)
      break if room.players.find_by(nickname: nickname).nil?
    end
  end
end
