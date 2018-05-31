class CreateListItems < ActiveRecord::Migration[5.1]
  def change
    create_table :list_items do |t|
      t.string :name
      t.text :description
      t.date :completed
      t.references :todo_list, foreign_key: true

      t.timestamps
    end
  end
end
