class Record < ApplicationRecord
  belongs_to :game
  belongs_to :player

  def self.fast_create(record_params)
    room_id = record_params[:room_id]
    records = record_params[:records]

    return '全為0' if all_zero?(records)
    
    return check_is_zero?(records) unless check_is_zero?(records) == 0
    game = Game.create(room_id: room_id)
    records.each do |record|
      next if record['score'].empty?
      game.records.create(record)
    end
    :success
  end

  private
  def self.check_is_zero?(records)
    sum = 0
    records.each do |record|
      sum += record['score'].to_i
    end
    sum
  end

  def self.all_zero?(records)
    records.each do |record|
      return false if record['score'] != ""
    end

    return true
  end
end
