class Game < ApplicationRecord
  belongs_to :room
  has_many :records, dependent: :destroy

  def display_time
    recorded_at.strftime("%F %T %P")
  end

  def update_by_records(params)
    records_params = params['records']
    scores = records_params.map {|r| r['score'] }
    return check_is_zero?(scores) unless check_is_zero?(scores) == 0
    records_params.each do |record|
      records.find_by(player_id: record['player_id']).update(score: record['score'])
    end
    :success
  end

  private
  def check_is_zero?(records)
    sum = 0
    records.each do |record|
      sum += record.to_i
    end
    sum
  end
end
