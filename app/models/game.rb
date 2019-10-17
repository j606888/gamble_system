class Game < ApplicationRecord
  belongs_to :room
  has_many :records

  def sort_record
     
    result = []
    players = room.players.includes(:records)
    players.each do |player|
      result << records.find_by(player_id: player.id)&.score || ''
    end

    result
  end
end
