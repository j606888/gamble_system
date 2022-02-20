class LineSource < ApplicationRecord
  belongs_to :room, optional: true
  has_many :room_maps
  has_many :rooms, through: :room_maps

  enum source_type: [:is_user, :is_group, :is_room]
end
