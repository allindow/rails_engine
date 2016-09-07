class Transaction < ApplicationRecord
  belongs_to :invoice
  scope :failed, -> { where(result: "failed") }
end
