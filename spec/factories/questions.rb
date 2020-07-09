FactoryBot.define do
  factory :question do
    label { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }

    trait :with_many_answers do
      answers_attributes { [
        FactoryBot.attributes_for(:answer, correct: true), FactoryBot.attributes_for(:answer, correct: false),
      ] }
    end
  end
end
