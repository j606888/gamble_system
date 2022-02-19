class DropRolify < ActiveRecord::Migration[5.2]
  def change
    drop_table :roles
    drop_table :users_roles
  end
end
