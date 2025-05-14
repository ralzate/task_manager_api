class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :status
      t.datetime :due_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :tasks, :status
    add_index :tasks, :due_date
  end
end
