Fabricator(:product) do
  name {Faker::Lorem.words(2).join('')}
  short_description {Faker::Lorem.words(2).join('')}
  long_description {Faker::Lorem.words(3).join("")}
end