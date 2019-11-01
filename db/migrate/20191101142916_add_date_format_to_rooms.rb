class AddDateFormatToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :date_format, :integer
  end
end
