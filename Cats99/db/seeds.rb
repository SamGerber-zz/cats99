10.times do
  name = Faker::Name.name
  color = Cat::COLORS.sample
  sex = Cat::SEX.sample
  birth_date = (Date.today - rand(10).years - rand(365).days).to_s
  description = Faker::Hacker.say_something_smart

  Cat.create!(name: name, color: color, sex: sex, birth_date: birth_date, description: description)
end
