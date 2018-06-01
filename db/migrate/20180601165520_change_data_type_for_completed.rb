class ChangeDataTypeForCompleted < ActiveRecord::Migration[5.1]
  def self.up
    change_table :list_items do |t|
      t.change :completed, :datetime
    end
  end
  def self.down
    change_table :tablename do |t|
      t.change :completed, :date
    end
  end
end
