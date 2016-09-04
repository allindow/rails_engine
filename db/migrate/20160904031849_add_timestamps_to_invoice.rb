class AddTimestampsToInvoice < ActiveRecord::Migration[5.0]
  def change
    change_table(:invoices) { |t| t.timestamps }
  end
end
