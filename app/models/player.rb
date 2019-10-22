class Player < ApplicationRecord
  belongs_to :room
  has_many :records

  scope :avaliable, -> { where(hidden: false).order(:id) }
  scope :winner, -> { all.includes(:records).sort_by(&:total_score).reverse! }
  scope :loser, -> { all.includes(:records).sort_by(&:total_score) }
  scope :counter, -> { all.includes(:records).sort_by(& game_times).reverse! }

  def total_score
    scores = records.map(&:score)
    scores.compact.reduce(:+) || 0
  end

  def game_times
    records.count
  end
end
