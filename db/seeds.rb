User.create!(user_name: "admin",
  full_name: "Bot admin",
  email: "admin@gmail.com",
  password: "111111",
  role: 1,
  activated: true)
99.times do |n|
  user_name = Faker::Name.name
  full_name = Faker::FunnyName.name_with_initial
  email = "example#{n+1}@railstutorial.org"
  password = "123123"
  User.create!(user_name: user_name,
               full_name: full_name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

