class AddTimestampsToInvoiceItems < ActiveRecord::Migration[5.0]
  def change
    change_table(:invoice_items) { |t| t.timestamps }
  end
end
