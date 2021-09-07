FactoryBot.define do
  factory :transaction do
    result {'success'}
    association :invoice, factory: :invoice_shipped
  end

  factory :transaction_failed, class: Transaction do
    result {'failed'}
    association :invoice, factory: :invoice_shipped
  end
end
