FactoryBot.define do
  
  factory :group do
    name {Faker::Team.name}
    users {[create(:user)]}
  end
end