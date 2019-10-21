class Player < ApplicationRecord
  belongs_to :room
  has_many :records

  def total_score
    scores = records.map(&:score)
    scores.compact.reduce(:+)
  end
end
