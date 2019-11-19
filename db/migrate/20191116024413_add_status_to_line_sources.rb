class AddStatusToLineSources < ActiveRecord::Migration[5.2]
  def change
    add_column :line_sources, :status, :integer
  end
end
