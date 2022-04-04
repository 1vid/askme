class AddBackGroundColorToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :bg_color, :string, null: false, default: '#5F9EA0'
  end
end
