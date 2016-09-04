class AddTimestampsToMerchant < ActiveRecord::Migration[5.0]
  def change
    change_table(:merchants) { |t| t.timestamps }
  end
end
