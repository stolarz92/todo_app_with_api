FactoryBot.define do
  factory :list_item do
    name { Faker::Lorem.word }
    todo_list
  end
end