class AddTimestampsToItem < ActiveRecord::Migration[5.0]
  def change
    change_table(:items) { |t| t.timestamps }
  end
end
