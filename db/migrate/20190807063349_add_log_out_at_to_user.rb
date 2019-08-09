class AddLogOutAtToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :log_out_at, :datetime
  end
end
