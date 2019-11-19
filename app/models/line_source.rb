class LineSource < ApplicationRecord
  before_create :setup_status
  belongs_to :room, optional: true
  enum source_type: [:is_user, :is_group, :is_room]
  enum status: [:unbind_mode, :normal_mode, :player_mode, :record_mode]

  private
  def setup_status
    self.status = 'normal_mode'
  end
end
