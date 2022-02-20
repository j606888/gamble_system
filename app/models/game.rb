class Game < ApplicationRecord
  belongs_to :room
  has_many :records, dependent: :destroy
  before_create :set_recorded_at

  private

  def set_recorded_at
    self.recorded_at ||= Time.now
  end
end
