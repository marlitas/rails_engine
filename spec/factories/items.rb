FactoryBot define do
  factory :item do
    name { Faker::Movies::StarWars.vehicle }
    description { Faker::Movies::StarWars.quote }
    unit_price {Faker::Number.decimal(l_digits: 3, r_digits: 2)}
    association :merchant, factory: :merchant
  end
end
