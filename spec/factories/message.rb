
FactoryBot.define do
  
  factory :message do
    content {Faker::Lorem.paragraph(1)}
    image {File.open("#{Rails.root}/public/images/test_image.jpg")}
    user
    group
  end
end