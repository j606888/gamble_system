class Record < ApplicationRecord
  belongs_to :game
  belongs_to :player

  scope :win, -> { where("score > 0") }
  scope :lose, -> { where("score < 0") }

  def self.to_hash(records)
    sum = 0
    score_array = records.map do |record|
      score = record['score'].to_i
      player = Player.find(record['player_id'])
      sum += score
      score = nil if score == 0
      {
        id: player.id,
        score: score,
        name: player.name
      }
    end
    {
      sum: sum,
      score_array: score_array
    }
  end
end
