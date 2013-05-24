class AddColumnCategoryidToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :category_id, :integer, :default => 1
  end
end
