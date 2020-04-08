# coding: utf-8

User.create!(name: "管理者",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)
             
10.times do |n|
  name  = "上長#{n+1}"
  email = "jotyo-1#{n+1}@email.com"
  password = "password"
  employees_number = "#{n+10}"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               employees_number: employees_number,
               superior: true)
end
             
60.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  employees_number = "#{n+100}"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               employees_number: employees_number)
end

Base.create!(user_id: "1",
             base_name: "H!P",
             base_number: "1995",
             base_kind: "アイドル")
