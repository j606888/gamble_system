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
end
