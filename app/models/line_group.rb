class LineGroup < ApplicationRecord
  belongs_to :room, optional: true
end
