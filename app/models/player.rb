class Player < ApplicationRecord
  belongs_to :room
  has_many :records

  scope :normal_order, -> { order(:id) }

  def total_score
    scores = records.map(&:score)
    scores.compact.reduce(:+)
  end
end
