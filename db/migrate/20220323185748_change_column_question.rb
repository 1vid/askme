class ChangeColumnQuestion < ActiveRecord::Migration[6.1]
  def change
    rename_column :questions, :question, :text
  end
end
