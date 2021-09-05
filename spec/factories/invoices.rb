FactoryBot.define do
  factory :invoice_shipped do
    status {'shipped'}
    description { Faker::Movies::StarWars.quote }
    unit_price {Faker::Number.decimal(l_digits: 3, r_digits: 2)}
    association :merchant, factory: :merchant
    association :customer, factory: :customer
  end

  factory :invoice_packaged do
    status {'packaged'}
    description { Faker::Movies::StarWars.quote }
    unit_price {Faker::Number.decimal(l_digits: 3, r_digits: 2)}
    association :merchant, factory: :merchant
    association :customer, factory: :customer
  end

  factory :invoice_returned do
    status {'returned'}
    description { Faker::Movies::StarWars.quote }
    unit_price {Faker::Number.decimal(l_digits: 3, r_digits: 2)}
    association :merchant, factory: :merchant
    association :customer, factory: :customer
  end
end
