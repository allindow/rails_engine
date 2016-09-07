FactoryGirl.define do
  factory :customer do
    first_name
    last_name
  end

  factory :merchant do
    name
  end

  factory :invoice do
    customer
    merchant
    status "shipped"
  end

  factory :item do
    name
    description "description for item"
    unit_price
    merchant
  end

  factory :invoice_item do
    item
    invoice
    quantity
    unit_price
  end

  factory :transaction do
    invoice
    credit_card_number "000-000-000-000"
    credit_card_expiration_date ""
    result "success"
  end

  sequence :first_name do |n|
    "FirstName #{n}"
  end

  sequence :last_name do |n|
    "LastName #{n}"
  end

  sequence :unit_price do |n|
    rand(100..1500)
  end

  sequence :name do |n|
    "Name #{n}"
  end

  sequence :quantity do |n|
    rand(1..10)
  end
end
