class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.text :content
      t.string :status
      t.date :deadline

      t.timestamps
    end
  end
end
