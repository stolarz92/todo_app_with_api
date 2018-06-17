# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.firqst)
3.times do |i|
  User.find_or_create_by!(email: "user_#{i + 1}@test.pl") do |user|
    user.password = 'password123'
  end
end

User.all.each do |user|
  5.times do |i|
    user.todo_lists.find_or_create_by!(name: "Lista #{i + 1}") do |list|
      list.description = "Suspendisse posuere consequat velit eget viverra."
    end
  end
end

TodoList.all.each do |list|
  10.times do |i|
    list.list_items.find_or_create_by!( name: "Zadanie #{i + 1}") do |item|
       item.description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    end
  end
end