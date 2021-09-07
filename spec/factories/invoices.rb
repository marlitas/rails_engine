FactoryBot.define do
  factory :invoice_shipped, class: Invoice do
    status {'shipped'}
    association :merchant, factory: :merchant
    association :customer, factory: :customer
  end

  factory :invoice_packaged, class: Invoice do
    status {'packaged'}
    association :merchant, factory: :merchant
    association :customer, factory: :customer
  end

  factory :invoice_returned, class: Invoice do
    status {'returned'}
    association :merchant, factory: :merchant
    association :customer, factory: :customer
  end
end
