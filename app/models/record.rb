class Record < ApplicationRecord
  belongs_to :game
  belongs_to :player

  def self.fast_create(record_params)
    room_id = record_params[:room_id]
    records = record_params[:records]

    return '全為0' if all_zero?(records)

    sum = records.map{|r| r['score'].to_i}.compact.sum
    return sum if sum != 0

    game = Game.create(room_id: room_id)
    records.each do |r|
      next if r['score'].empty?
      game.records.create(r)
    end
    :success
  end

  private

  def self.all_zero?(records)
    records.each do |record|
      return false if record['score'] != ""
    end

    return true
  end
end
