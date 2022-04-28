FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 6)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Lorem.characters(number:6, min_alpha:1, min_numeric:1)}
    password_confirmation {password}
    family_type_id        {Faker::Number.between(from:1, to: 7)}
    eatout_freq_id        {Faker::Number.between(from:1, to: 4)}
    appetite_id           {Faker::Number.between(from:1, to: 3)}
  end
end
