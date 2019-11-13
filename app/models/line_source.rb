class LineSource < ApplicationRecord
  belongs_to :room, optional: true
  enum source_type: [:is_user, :is_group, :is_room]
end
