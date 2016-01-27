101.times do
  name = Faker::Name.name
  color = Cat::COLORS.sample
  sex = Cat::SEX.sample
  birth_date = (Date.today - rand(10).years - rand(365).days).to_s
  description = Faker::Hacker.say_something_smart

  Cat.create!(name: name, color: color, sex: sex, birth_date: birth_date, description: description)
end

# Non-Overlapping Pending
working_cat = Cat.first
CatRentalRequest.create(cat_id: working_cat.id, start_date: 10.days.ago, end_date: 5.days.ago)
CatRentalRequest.create(cat_id: working_cat.id, start_date: 20.days.ago, end_date: 11.days.ago)

# Overlapping Pending
working_cat = Cat.all[1]
CatRentalRequest.create(cat_id: working_cat.id, start_date: 10.days.ago, end_date: 5.days.ago)
CatRentalRequest.create(cat_id: working_cat.id, start_date: 20.days.ago, end_date: 9.days.ago)
CatRentalRequest.create(cat_id: working_cat.id, start_date: 30.days.ago, end_date: 1.days.ago)
CatRentalRequest.create(cat_id: working_cat.id, start_date: 20.days.ago, end_date: 6.days.ago)
