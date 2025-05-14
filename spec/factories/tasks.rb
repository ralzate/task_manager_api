FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph }
    status { %w[pending in_progress completed].sample }
    due_date { Faker::Date.between(from: 1.day.from_now, to: 30.days.from_now) }
    user
  end
end