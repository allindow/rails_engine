class AddTimestampsToCustomer < ActiveRecord::Migration[5.0]
  def change
    change_table(:customers) { |t| t.timestamps }
  end
end
