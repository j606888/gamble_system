class Player < ApplicationRecord
  belongs_to :room
  has_many :records, dependent: :destroy

  scope :avaliable, -> { where(hidden: false).order(:id) }
  scope :winner, -> { all.includes(:records).sort_by(&:total_score).reverse! }
  scope :loser, -> { all.includes(:records).sort_by(&:total_score) }
  scope :counter, -> { all.includes(:records).sort_by(&:game_times).reverse! }

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
    {
      id: id,
      name: name,
      total_score: total_score,
      game_count: game_count,
      win: win_count,
      lose: lose_count,
      win_rate: "#{(win_rate * 100).to_i}%",
      average: (total_score.to_f / game_count).round(2)
    }
  end
end
