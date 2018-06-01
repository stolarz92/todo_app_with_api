FactoryBot.define do
  factory :todo_list do
    name { Faker::Lorem.word }
    user
  end
end