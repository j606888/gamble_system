class Game < ApplicationRecord
  belongs_to :room
  has_many :records, dependent: :destroy

  before_create :setup_default_time

  def display_time
    recorded_at.strftime("%F %T %P")
  end

  def update_by_records(records_hash)
    sum = records_hash.map { |r| r['score'].to_i }.sum
    return sum if sum != 0

    records_hash.each do |r|
      record = records.find_by(player_id: r['player_id'])
      record.update!(score: r['score'])
    end
    :success
  end

  private

  def setup_default_time
    self.recorded_at ||= Time.now
  end
end
