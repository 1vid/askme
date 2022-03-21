class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :questions
      t.string :answer
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
