FactoryBot.define do

  factory :answer do
    user
    sequence :body do |n|
      "MyText#{n}"
    end
  end

  trait :invalid do
    body { nil }
  end

end
