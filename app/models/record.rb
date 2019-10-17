class Record < ApplicationRecord
  belongs_to :game
  belongs_to :player

  def self.fast_create(record_params)
    room_id = record_params[:room_id]
    records = record_params[:records]

    return unless check_is_zero?(records)
    game = Game.create(room_id: room_id, recorded_at: Time.now)
    game.records.create(records)
    game.room
  end

  private
  def self.check_is_zero?(records)
    sum = 0
    records.each do |record|
      sum += record['score'].to_i
    end
    sum == 0
  end
end
