FactoryBot.define do
  
  factory :group do
    name {Faker::Team.name}
    users {[build(:user)]}
  end
end