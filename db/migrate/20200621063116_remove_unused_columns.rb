class RemoveUnusedColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :line_sources, :status
  end
end
