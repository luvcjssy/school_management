FactoryBot.define do
  factory :test do
    name { Faker::Educator.subject }
    description { Faker::Lorem.paragraph }

    trait :with_many_questions do
      questions_attributes { [
        FactoryBot.attributes_for(:question, :with_many_answers), FactoryBot.attributes_for(:question, :with_many_answers)
      ] }
    end
  end
end
