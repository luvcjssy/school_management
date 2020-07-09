FactoryBot.define do
  factory :answer do
    result { Faker::Lorem.word }
    correct {[true, false].sample}
  end
end
