FactoryBot.define do
  factory :transaction do
    association :invoice, factory: :invoice_shipped
  end
end
