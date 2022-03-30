class AddBackGroundColorToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :bg_color, :string
  end
end
