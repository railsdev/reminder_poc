class AddParentIdFieldToReminder < ActiveRecord::Migration
  def change
    add_column :reminders, :parent_id, :integer
  end
end
