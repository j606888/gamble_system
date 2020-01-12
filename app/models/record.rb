class Record < ApplicationRecord
  belongs_to :game
  belongs_to :player

  scope :win, -> { where("score > 0") }
  scope :lose, -> { where("score < 0") }

  def self.to_message(records)
    message = records.map do |record|
      score = record['score'].to_i
      next if score == 0
      player = Player.find(record['player_id'])
      "#{player.nickname} #{score}"
    end
    message.compact.join("\n")
  end
end
