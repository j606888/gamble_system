class RoomMap < ApplicationRecord
  belongs_to :line_source
  belongs_to :room
end
