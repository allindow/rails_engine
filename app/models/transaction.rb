class Transaction < ApplicationRecord
  belongs_to :invoice
  scope :failed, -> { where(result: "failed") }
  scope :success, -> { where(result: "success") }
end
